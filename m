From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 17 Aug 2017 10:21:08 +0300
Subject: Centralize nvme controller reset, delete and fabrics periodic
 reconnects
In-Reply-To: <20170816151723.GA18932@lst.de>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
 <20170816104935.GA30525@lst.de>
 <de413980-1382-7567-b0d4-3207a4476719@grimberg.me>
 <20170816151723.GA18932@lst.de>
Message-ID: <d3ee0b6c-feac-8e40-f658-4791e454f60e@grimberg.me>


>> Having said that, I'm very much open to suggestions if you have anything
>> better in mind...
> 
> Not too many suggestions - you want to see it done before we go on
> merging the code..

Something is not adding up in your reply :)

You want to see it done before we merge? Or are you asking if I
want to see it done? I designed it to be incremental and not
break existing transports.

Personally I think that pci conversion will have to be incremental
and gradual as we need some preparations in place first. So if you are
reluctant to get it in without full conversion its ok, just note it will
take me some time to get both pci and fc converted.
