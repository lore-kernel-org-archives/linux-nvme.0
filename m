From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 8 Nov 2018 08:05:23 +0800
Subject: [RFC PATCH] nvme of: don't flush scan work inside reset context
In-Reply-To: <5f193243-a0a7-8f9f-7d7b-7f3f87a7fdae@grimberg.me>
References: <20181105115734.15515-1-ming.lei@redhat.com>
 <97aae455-fa74-b1aa-21f6-80c03732a573@grimberg.me>
 <20181107035107.GA6920@ming.t460p>
 <f1167108-0e3f-0b64-d9c3-399f4dec73d3@grimberg.me>
 <20181107083412.GA8878@ming.t460p>
 <5f193243-a0a7-8f9f-7d7b-7f3f87a7fdae@grimberg.me>
Message-ID: <20181108000522.GA15911@ming.t460p>

On Wed, Nov 07, 2018@10:38:44AM -0800, Sagi Grimberg wrote:
> 
> > https://bugzilla.redhat.com/show_bug.cgi?id=1622487
> > https://bugzilla.redhat.com/show_bug.cgi?id=1628100
> > 
> > Especially you may find some details in the following comment:
> > 
> > https://bugzilla.redhat.com/show_bug.cgi?id=1628100#c7
> 
> I don't have permissions to see the tickets.

But I have explained the issue in enough details, don't I?

Thanks,
Ming
