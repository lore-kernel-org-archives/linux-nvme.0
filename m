From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 7 May 2019 05:13:01 +0900
Subject: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
In-Reply-To: <SN6PR04MB4527FAD8076A5A5610F6B66786300@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>
 <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <cfa4d48d-ce13-0ace-cf5c-a3d0d1f4cca7@gmail.com>
 <SN6PR04MB4527FAD8076A5A5610F6B66786300@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <c86fe09e-9964-123a-bc17-e9b9e6a80856@gmail.com>

> I wasn't clear enough.
> 
> It doesn't check for the return value for now. What needs to happen is :-
> 
> 1. Get rid of the variable strings which are not part of the discovery
>      log page entries such as Generation counter.
> 2. Validate each log page entry content.

Question again here.
Do you mean that log page entry contents validation should be in bash 
level instead of *.out comparison?

> 3. Check the return value.

nvme-cli is currently returning value like:
   > 0 :   failed with nvme status code (but the actual value may not be 
the same with status)
   == 0 : done successfully
   < 0 :   failed with -errno

But, ( > 0) case may be removed from nvme-cli soon due to [1] discuss. 
Anyway, if nvme-cli is going to return 0 for both cases: success, error 
with nvme status, then test case is going to be hard to check the error 
status by a return value.  It should be with output string parsing which 
would be great if it's going to be commonized.

[1] https://github.com/linux-nvme/nvme-cli/pull/492
