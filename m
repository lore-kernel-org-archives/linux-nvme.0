From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 20 Aug 2017 09:37:55 +0300
Subject: Centralize nvme controller reset, delete and fabrics periodic
 reconnects
In-Reply-To: <20170817073620.GA24372@lst.de>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
 <20170816104935.GA30525@lst.de>
 <de413980-1382-7567-b0d4-3207a4476719@grimberg.me>
 <20170816151723.GA18932@lst.de>
 <d3ee0b6c-feac-8e40-f658-4791e454f60e@grimberg.me>
 <20170817073620.GA24372@lst.de>
Message-ID: <434101e0-7efd-eb98-211e-3ae540fa73a1@grimberg.me>


>> You want to see it done before we merge? Or are you asking if I
>> want to see it done? I designed it to be incremental and not
>> break existing transports.
>>
>> Personally I think that pci conversion will have to be incremental
>> and gradual as we need some preparations in place first. So if you are
>> reluctant to get it in without full conversion its ok, just note it will
>> take me some time to get both pci and fc converted.
> 
> I'd really like to see at least a demo PCI conversion.

Let me see what if I can allocate some time for it.

> Guess I need to take care of it then.

If you feel this is a gating item for inclusion then your help will be
highly appreciated.
