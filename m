From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 7 May 2019 19:43:57 +0900
Subject: [PATCH V2 2/2] nvme-trace: Add support to trace fabrics command
In-Reply-To: <SN6PR04MB4527DB454B2CF9170B32464386310@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <SN6PR04MB4527A10184AEF3DDCC23CB0886300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <20190506194644.11109-1-minwoo.im.dev@gmail.com>
 <20190506194644.11109-3-minwoo.im.dev@gmail.com>
 <CGME20190506223810epcas4p224242aa97518322bcbe2aa11d39d84a3@epcms2p6>
 <20190506225645epcms2p6b5efa570eade06b215b78418a0fbfdcc@epcms2p6>
 <SN6PR04MB4527DB454B2CF9170B32464386310@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <7a07f98a-64c2-1f82-a69d-bd3a5412a73d@gmail.com>

> I really like the idea of tracing for NVMeOF. However I think we need to
> design the tracing code
> 
> so that common code for host and target will get share. That is the main
> reason I want both the
> 
> host and target side tracing to be done in the one patch-series. Even if
> it is taking longer we are
> 
> fine with that.
> 
> So ideally patch series should look like this :-
> 
> 1. NVMe-Core tracing change for fabrics commands and common code
> preparation patches.
> 
> 2. NVMe Host tracing changes.
> 
> 3. NVMe Target Tracing changes.
> 
> I'm fine with the interchanging order of 2 & 3.
> 
> any thoughts ?

I'm fine if it takes time.  will prepare V3 patch with what you have 
proposed above.

Thanks.

> I'm not sure having additional branches for tracing is a good idea in
> the kernel
> 
> where tracing is disabled, that is objective, if maintainers are okay
> with that let's
> 
> keep it that way.

I don't like conditional branches here neither.  Let me have a time to 
catch some idea about it.

> You are absolutely right. Since it is been used several places now this
> is good time
> 
> to have a preparation patch, and I don't think we should delay it more.
> 
> Also for host and target NVMeOF tracing it will be useful if we
> encounter same
> 
> scenario.

If other people agree on this, will prepare right away.

Thanks for your kindly review, Chaitanya.
