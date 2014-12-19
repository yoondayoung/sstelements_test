
#ifndef _H_SST_ELEMENTS_EMBER_AMR_FILE
#define _H_SST_ELEMENTS_EMBER_AMR_FILE

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

namespace SST {
namespace Ember {

class EmberAMRFile {

public:
	EmberAMRFile(char* amrPath, Output* out) :
		amrFilePath(amrPath),
		output(out) {

		amrFile = fopen(amrFilePath, "rt");

		if(NULL == amrFile) {
			output->fatal(CALL_INFO, -1, "Unable to open file: %s\n", amrPath);
		}

		char* headerLine = readLine();

		if(NULL == headerLine) {
			output->fatal(CALL_INFO, -1, "Error reading header file for AMR blocks in: %s\n", amrPath);
		}

		char* blockCountStr  = strtok(headerLine, " ");
		char* refineLevelStr = strtok(NULL, " ");
		char* blocksXStr     = strtok(NULL, " ");
		char* blocksYStr     = strtok(NULL, " ");
		char* blocksZStr     = strtok(NULL, " ");

		totalBlockCount = atoi(blockCountStr);
		maxRefinementLevel = atoi(refineLevelStr);
		blocksX = atoi(blocksXStr);
		blocksY = atoi(blocksYStr);
		blocksZ = atoi(blocksZStr);

		out->verbose(CALL_INFO, 8, 0, "Read mesh header info: blocks=%" PRIu32 ", max-lev: %" PRIu32 " bkX=%" PRIu32 ", blkY=%" PRIu32 ", blkZ=%" PRIu32 "\n",
			totalBlockCount, maxRefinementLevel, blocksX, blocksY, blocksZ);
	}

	char* readLine() {
		char* theLine = (char*) malloc(sizeof(char) * 64);
		int nextIndex = 0;
		char nextChar;

		while( (nextChar = fgetc(amrFile)) != '\n' && (nextChar != EOF) ) {
			theLine[nextIndex] = nextChar;
			nextIndex++;
		}

		theLine[nextIndex] = '\0';

		output->verbose(CALL_INFO, 32, 0, "Read line: %s\n", theLine);

		return theLine;
	}

	void readNodeMeshLine(uint32_t* blockCount) {
		char* nextLine = readLine();

		*blockCount = (uint32_t) atoi(nextLine);

		free(nextLine);
	}

	void readNextMeshLine(uint32_t* blockID, uint32_t* refineLev,
		int32_t* xDown, int32_t* xUp,
		int32_t* yDown, int32_t* yUp,
		int32_t* zDown, int32_t* zUp) {

		char* nextLine = readLine();

		char* blockIDStr     = strtok(nextLine, " ");
		char* refineLevelStr = strtok(NULL, " ");
		char* xDStr          = strtok(NULL, " ");
		char* xUStr          = strtok(NULL, " ");
		char* yDStr          = strtok(NULL, " ");
		char* yUStr          = strtok(NULL, " ");
		char* zDStr          = strtok(NULL, " ");
		char* zUStr          = strtok(NULL, " ");

		*blockID   = (uint32_t) atoi(blockIDStr);
		*refineLev = (uint32_t) atoi(refineLevelStr);
		*xDown     = (int32_t) atoi(xDStr);
		*xUp       = (int32_t) atoi(xUStr);
		*yDown     = (int32_t) atoi(yDStr);
		*yUp       = (int32_t) atoi(yUStr);
		*zDown     = (int32_t) atoi(zDStr);
		*zUp       = (int32_t) atoi(zUStr);

		free(nextLine);
	}

	uint32_t getBlocksX() const { return (uint32_t) blocksX; }
	uint32_t getBlocksY() const { return (uint32_t) blocksY; }
	uint32_t getBlocksZ() const { return (uint32_t) blocksZ; }

	uint32_t getBlockCount() const { return (uint32_t) totalBlockCount; }
	uint32_t getMaxRefinement() const { return (uint32_t) maxRefinementLevel; }

private:
	Output* output;
	char* amrFilePath;
	FILE* amrFile;

	int totalBlockCount;
	int maxRefinementLevel;
	int blocksX;
	int blocksY;
	int blocksZ;

};

}
}

#endif
