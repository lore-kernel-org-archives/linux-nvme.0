From: axboe@fb.com (Jens Axboe)
Date: Wed, 28 Oct 2015 16:40:08 +0900
Subject: [PATCH] Update target repo for nvme patch contributions
In-Reply-To: <1445362718.2819.40.camel@linux.intel.com>
References: <1445017711-4371-1-git-send-email-james_p_freyensee@linux.intel.com>
 <20151016234700.GA13234@localhost.localdomain>
 <20151018182337.GB21211@lst.de> <1445362718.2819.40.camel@linux.intel.com>
Message-ID: <56307BD8.50001@fb.com>

On 10/21/2015 02:38 AM, J Freyensee wrote:
> On Sun, 2015-10-18@20:23 +0200, Christoph Hellwig wrote:
>> On Fri, Oct 16, 2015@11:47:01PM +0000, Busch, Keith wrote:
>>> This is not in drivers/block anymore, so question to Jens: do you
>>> want
>>> to take on maintenance for driver/nvme? We've been doing it this
>>> way
>>> de-facto for the past year, so if you're okay with listing your
>>> tree
>>> for nvme, that's definitely okay with me too.
>>>
>>> I'll just throw out for the next merge window that I'm happy to
>>> herd all
>>> the nvme patches out there into a pull request in a public tree if
>>> that
>>> would help.
>>>
>>> I've started this one, so far just with Christoph's latest, plus a
>>> fix
>>> from me from the fallout:
>>>
>>>    https://urldefense.proofpoint.com/v2/url?u=http-3A__git.infradead.org_users_kbusch_linux-2Dnvme.git&d=CwICaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=cK1a7KivzZRh1fKQMjSm2A&m=3AfOrn0ifjKoR8xsyCHph2U_vW-xG3azjYonUOj09Mg&s=NARqRAFtEV9htXna-eRgE0NfEEDmWuf-G6vG_rkkKf8&e=
>>>
>>> I'll be happy to add patches from other developers that appear to
>>> have
>>> been left behind as well.
>>
>> A nvme tree sounds useful to me, and I'd love to see you handle it.
>>
>> But for now I think it might be a good idea if it gets pulled by Jens
>> into the block layer tree given that nvme is driving a lot of the
>> block
>> layer work and having both merged early is going to make everyones
>> life
>> a lot easier.
>
> Let me know if there is a different target or other info you'd like me
> to add to this patch and I'll change it.

I added your patch, and made the maintainer changes as well. As 
Christoph said, keeping it in the block tree for now will make life 
easier in the near future, as there will be dependency changes between 
blk-mq and nvme. We can always change this later, if there's a need or 
desire for that.

-- 
Jens Axboe
