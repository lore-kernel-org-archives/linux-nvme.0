From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 14 Oct 2015 11:17:20 -0700
Subject: [PATCH 08/11] nvme: suspend i/o during runtime
 blk_integrity_unregister
In-Reply-To: <alpine.LNX.2.00.1510141355250.27742@localhost.lm.intel.com>
References: <20151014022757.34443.25800.stgit@dwillia2-desk3.jf.intel.com>
 <20151014022841.34443.28017.stgit@dwillia2-desk3.jf.intel.com>
 <alpine.LNX.2.00.1510141355250.27742@localhost.lm.intel.com>
Message-ID: <CAPcyv4iCGu4osMe+SJTykDQjx103DzDdamqkK0J6b=H3Y5OHRw@mail.gmail.com>

On Wed, Oct 14, 2015@6:59 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Tue, 13 Oct 2015, Dan Williams wrote:
>>
>> Synchronize pending i/o against a change in the integrity profile to
>> avoid the possibility of spurious integrity errors.
>
>
> Looks good. Do we need to freeze the queue if we are register an
> integrity profile as well?
>

Indeed we do, I'll refresh the patch.  Thanks for that catch.
