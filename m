From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 13 Nov 2017 22:48:32 +0200
Subject: [PATCH v3 0/9] Introduce per-device completion queue pools
In-Reply-To: <20171113203444.GJ22610@ziepe.ca>
References: <20171108095742.25365-1-sagi@grimberg.me>
 <1510245771.2608.6.camel@wdc.com>
 <d5820b65-b428-7cd1-f7f1-7d8d89d21cf5@grimberg.me>
 <1510248716.2608.17.camel@wdc.com>
 <6af627c8-2814-d562-21a2-f10788e44458@grimberg.me>
 <20171113203444.GJ22610@ziepe.ca>
Message-ID: <75a7cfe3-58e0-b416-0b5b-beba1e8207fd@grimberg.me>


>> But if that is not the case, maybe we may have less completion
>> aggragation per interrupt.
> 
> It is too bad we can't re-size CQs.. Can we?

I wish we could, but its an optional feature so I can't see how we can
use it.
