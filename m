From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 19 Oct 2017 10:38:25 +0000
Subject: NVMe target log page offset not supported
In-Reply-To: <6d0126ad-90bd-11c2-ad4d-21e6fd32c0a7@grimberg.me>
References: <A5F28D4A728A7E41839CDC5C3B5A01E887295CEF@FMSMSX103.amr.corp.intel.com>
 <20171019085111.GB14227@lst.de> <mqdh8uv1pa7.fsf@linux-x5ow.site>
 <MWHPR04MB1008D60CB5469DD12F6896BE86420@MWHPR04MB1008.namprd04.prod.outlook.com>,
 <6d0126ad-90bd-11c2-ad4d-21e6fd32c0a7@grimberg.me>
Message-ID: <MWHPR04MB10088DF73F1E6CEB0F07F09F86420@MWHPR04MB1008.namprd04.prod.outlook.com>

Sure, I'll post a patch series for the latest version.

With the new structure of the code, it should be easy to add nvme plug-in from the nvmetcli.

Prior to that what I'm looking for in the comments:-

1. What are new file system types we should add in the utils? 
2. Is threading model on the host side needs to be replicated on the target side?
3. Right now we have a single thread for each namespace and associated work queue to execute the command on the namespace for the host, similar to namespace do we really need a separate thread for each controller also on the host side? What about target side controller.
4. Any specific fio workloads need to be added for basic testing?

Any other comments.

Regards,
-Chaitanya
  
From: Sagi Grimberg <sagi@grimberg.me>
Sent: Thursday, October 19, 2017 3:01:24 AM
To: Chaitanya Kulkarni; Johannes Thumshirn
Cc: Verkamp, Daniel; linux-nvme at lists.infradead.org; Hannes Reinecke; Christoph Hellwig
Subject: Re: NVMe target log page offset not supported
?   
> Hi Johannes,
> 
> I was able to incorporate all the comments received on the first version and added some new testcases.
> 
> Please have a look at the following link:-
> 
> https://github.com/ChaitanayaKulkarni/nvmftests.

 https://avatars3.githubusercontent.com/u/24584550?s=400&v=4 

ChaitanayaKulkarni/nvmftests
github.com
Contribute to nvmftests development by creating an account on GitHub.

> 
> Following is the list of the changes since V1 :-
> 
>????? 1. Addition of new testcases to improve the coverage.
>????? 2. Improved directory structure for code clarity.
>????? 3. Libification of the common code.
>????? 4. Support to use different block devices on the target side.
>????? 5. Centralize test configuration management.
>????? 6. Support to execute File System related operations on the host side.
>????? 7. Adjust the code to incorporate the comments received for the
>???????? first version.
>????? 8. Support for setting different log levels for each component.
>????? 9. Support for quick performance measurements.
>????? 10. Class hierarchy documentation and sequence diagram.
>????? 11. Improved workqueue management for host namesapce to
>????????? run parallel commands.

Hi Chaitanya,

Would it be possible to post patches so we can effectively provide
feedback?

One thing by a 5 seconds browse, its a shame that you work directly
on top of configfs and not import nvme plugin from nvmetcli repo...
    
