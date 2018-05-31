From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 13:27:02 +0300
Subject: [PATCHv2 11/11] nvmet: ANA support
In-Reply-To: <20180525133455.GA24759@lst.de>
References: <20180522091004.39620-1-hare@suse.de>
 <20180522091004.39620-12-hare@suse.de> <20180522100552.GC11894@lst.de>
 <c7e3cbcc-e372-8162-0d84-1fced2ccc3c2@suse.de>
 <20180525133455.GA24759@lst.de>
Message-ID: <c33aa33f-8559-e0b0-cfe7-719c34385aee@grimberg.me>


>> Primarily this is designed to be a testbed for the various ANA
>> configurations.
> 
> Well, hat isn't really what we need in mainline.
> 
>> Plus ANA support can be disabled, too :-)
> 
> Great.  That should be worth about 20 lines if we really need it,
> not 370 lines of additional code over the initial 315.  And not
> require iterating the list of all ANA groups in the ANA fast path.
> And so on.

Hey Hannes, Christoph,

I'm trying to catch up, and reviewed this set. Didn't see a v2 for this
but only "NVMe ANA fixups".. is this supposed to be v2?
