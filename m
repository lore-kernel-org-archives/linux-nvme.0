From: jsmart2021@gmail.com (James Smart)
Date: Wed, 13 Jun 2018 08:15:22 -0700
Subject: [PATCH v3 2/4] nvme_fc: change controllers first connect to use
 reconnect path
In-Reply-To: <20180613113150.GB18531@infradead.org>
References: <20180612235028.17969-1-jsmart2021@gmail.com>
 <20180612235028.17969-3-jsmart2021@gmail.com>
 <20180613113150.GB18531@infradead.org>
Message-ID: <60013886-182c-0ab1-ef99-b681a97ea99f@gmail.com>

On 6/13/2018 4:31 AM, Christoph Hellwig wrote:
>> Note: this patch is dependent on these changes that have been
>> added to the nvme-cli utility:
>> - nvme-cli: Wait for device file if not present after successful add_ctrl
>> - nvme-cli: Add ioctl retry support for "connect-all"
> 
> Which means it breaks backwards compatibility.  We can't do that.

I don't know what compatibility you are talking about. Both of those 
issues could be hit even with the non-async implementation.

The cli has already been updated and addressed them.


> 
> IFF we actually end up wanting async connect it needs to be an
> explicit opt-it with a new option.
> 
> In the meantime I really like this code in general, so please resubmit
> it with a flush_delayed_work to make it synchronus.

I disagree. No user is aware of the async vs sync nature. It's the 
non-delay of the create thread that allows the simplistic udev scripts.

-- james
