From: keith.busch@intel.com (Keith Busch)
Date: Fri, 25 Jan 2019 16:37:43 -0700
Subject: [PATCH] nvme: Block ns inventory changes during admin
In-Reply-To: <OF5147C249.BC64CC03-ON0025838D.007F28EE-8625838D.007F6785@notes.na.collabserv.com>
References: <20190125194819.11476-1-keith.busch@intel.com>
 <OF5147C249.BC64CC03-ON0025838D.007F28EE-8625838D.007F6785@notes.na.collabserv.com>
Message-ID: <20190125233742.GA11722@localhost.localdomain>

[replying in plain-text for mailing list posterity]
On Fri, Jan 25, 2019@05:11:35PM -0600, Wen Xiong wrote:
> Hi Keith,
> 
> I have tested the patch and fixed the two hung issues on our system.
> 
> >>Reported-by: Wen Xiong <wenxiong at us.ibm.com>
> >>Signed-off-by: Keith Busch <keith.busch at intel.com>
> 
> Tested-by: Wen Xiong<wenxiong at us.ibm.com>
> 
> Thanks,
> Wendy

Thank you for confirming this fixes your issue.
