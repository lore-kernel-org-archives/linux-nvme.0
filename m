From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 19 Oct 2017 13:01:24 +0300
Subject: NVMe target log page offset not supported
In-Reply-To: <MWHPR04MB1008D60CB5469DD12F6896BE86420@MWHPR04MB1008.namprd04.prod.outlook.com>
References: <A5F28D4A728A7E41839CDC5C3B5A01E887295CEF@FMSMSX103.amr.corp.intel.com>
 <20171019085111.GB14227@lst.de> <mqdh8uv1pa7.fsf@linux-x5ow.site>
 <MWHPR04MB1008D60CB5469DD12F6896BE86420@MWHPR04MB1008.namprd04.prod.outlook.com>
Message-ID: <6d0126ad-90bd-11c2-ad4d-21e6fd32c0a7@grimberg.me>

> Hi Johannes,
> 
> I was able to incorporate all the comments received on the first version and added some new testcases.
> 
> Please have a look at the following link:-
> 
> https://github.com/ChaitanayaKulkarni/nvmftests.
> 
> Following is the list of the changes since V1 :-
> 
>      1. Addition of new testcases to improve the coverage.
>      2. Improved directory structure for code clarity.
>      3. Libification of the common code.
>      4. Support to use different block devices on the target side.
>      5. Centralize test configuration management.
>      6. Support to execute File System related operations on the host side.
>      7. Adjust the code to incorporate the comments received for the
>         first version.
>      8. Support for setting different log levels for each component.
>      9. Support for quick performance measurements.
>      10. Class hierarchy documentation and sequence diagram.
>      11. Improved workqueue management for host namesapce to
>          run parallel commands.

Hi Chaitanya,

Would it be possible to post patches so we can effectively provide
feedback?

One thing by a 5 seconds browse, its a shame that you work directly
on top of configfs and not import nvme plugin from nvmetcli repo...
