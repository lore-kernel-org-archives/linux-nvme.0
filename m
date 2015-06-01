From: Stephen.Bates@pmcs.com (Stephen Bates)
Date: Mon, 1 Jun 2015 13:54:57 +0000
Subject: [NVME-CLI] Status Update
In-Reply-To: <36F6EBABA23FEF4391AF72944D228901B6BE3A8F@BBYEXM01.pmc-sierra.internal>
References: <36F6EBABA23FEF4391AF72944D228901B6BE2CD7@BBYEXM01.pmc-sierra.internal>
 <20150528071844.GA25896@infradead.org>
 <36F6EBABA23FEF4391AF72944D228901B6BE3A8F@BBYEXM01.pmc-sierra.internal>
Message-ID: <36F6EBABA23FEF4391AF72944D228901B6BEB647@BBYEXM01.pmc-sierra.internal>

Hi All

>> Hi All
>> 
>> I just wanted to send out an update on the nvme-cli tool that Keith and I have been maintaining. We have performed a few upgrades over the past few months and based on traffic this tool seems to be >getting some amount of usage. 
>> 
>> 1. Code is available here - https://github.com/linux-nvme/nvme-cli
>> 2. Code is now Apache licensed (except for the nvme.h file which of course has to be GPL). Hopefully this will encourage adoption.>
>
>How can you use a GPL header in an otherwise Apache licenced program?
>That's contrictory licensing that makes distributing the tool basically impossible.

Thank you Christoph for pointing out the fact that license mixing is not going to work. After some discussion with Keith and legal we have decided the most prudent thing to do is revert nvme-cli to GPL licensing. I will be doing this later this week. My apologies for any confusion.

Cheers

Stephen

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Stephen Bates
Sent: Thursday, May 28, 2015 5:00 AM
To: Christoph Hellwig
Cc: Busch, Keith; linux-nvme at lists.infradead.org
Subject: RE: [NVME-CLI] Status Update

Christoph

Hmmm I should begin by saying I am not a lawyer ;-). I was under the impression that the dual licensing option was valid. However, I have passed your comment along to someone who is more knowledgeable on this topic than I am and will get back to you. We do want to make nvme-cli distributable under Apache so we will see what the options are.

Cheers

Stephen Bates, PhD
Technical Director, CSTO
PMC-Sierra
Cell: +1 403 609 1784
Twitter: @stepbates

-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org] 
Sent: Thursday, May 28, 2015 1:19 AM
To: Stephen Bates
Cc: linux-nvme at lists.infradead.org; Busch, Keith
Subject: Re: [NVME-CLI] Status Update

On Wed, May 27, 2015@10:28:20PM +0000, Stephen Bates wrote:
> Hi All
> 
> I just wanted to send out an update on the nvme-cli tool that Keith and I have been maintaining. We have performed a few upgrades over the past few months and based on traffic this tool seems to be getting some amount of usage. 
> 
> 1. Code is available here - https://github.com/linux-nvme/nvme-cli
> 2. Code is now Apache licensed (except for the nvme.h file which of course has to be GPL). Hopefully this will encourage adoption.

How can you use a GPL header in an otherwise Apache licenced program?
That's contrictory licensing that makes distributing the tool basically impossible.


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
