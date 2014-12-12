// Copyright 2009-2014 Sandia Corporation. Under the terms
// of Contract DE-AC04-94AL85000 with Sandia Corporation, the U.S.
// Government retains certain rights in this software.
//
// Copyright (c) 2009-2014, Sandia Corporation
// All rights reserved.
//
// This file is part of the SST software package. For license
// information, see the LICENSE file in the top level directory of the
// distribution.


#ifndef _H_EMBER_COMM_SPLIT_EV
#define _H_EMBER_COMM_SPLIT_EV

#include "emberevent.h"

namespace SST {
namespace Ember {

class EmberCommSplitEvent : public EmberMPIEvent {

public:
    EmberCommSplitEvent( MP::Interface& api, Output* output, Histo* histo,
          Communicator oldComm, int color, int key, Communicator* newComm ) 
      : EmberMPIEvent( api, output, histo ),
        m_oldComm( oldComm), 
        m_color(color), 
        m_key(key), 
        m_newComm(newComm)
    {}
    ~EmberCommSplitEvent() {}

   std::string getName() { return "CommSplit"; }

    void issue( uint64_t time, FOO* functor ) {

        m_output->verbose(CALL_INFO, 1, 0, "\n");

        EmberEvent::issue( time );

        m_api.comm_split( m_oldComm, m_color, m_key, m_newComm, functor );
    }


private:
	Communicator m_oldComm;
    int m_color;
    int m_key;
    Communicator* m_newComm;
};

}
}

#endif