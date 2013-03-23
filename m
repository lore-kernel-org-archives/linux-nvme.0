From: keith.busch@intel.com (Keith Busch)
Date: Fri, 22 Mar 2013 22:16:59 -0600 (MDT)
Subject: [PATCH] NVMe: Do not save result for range type feature
In-Reply-To: <20130403123809.GO4671@linux.intel.com>
References: <1364934695-24351-1-git-send-email-keith.busch@intel.com>
 <20130403123809.GO4671@linux.intel.com>
Message-ID: <alpine.LRH.2.03.1303222215500.17928@localhost.localdom>

On Wed, 3 Apr 2013, Matthew Wilcox wrote:

> On Tue, Apr 02, 2013@02:31:35PM -0600, Keith Busch wrote:
>> The LBA range type feature being optional, we do not want to save
>> the result or propagate it up the call stack when a device does not
>> support it.
>
> Looking at the whole function, the description of what it returns
> is rather odd.  "If nvme_setup_io_queues fails, returns that error.
> If nvme_identify for the controller fails, returns -EIO.  Otherwise,
> return an error if nvme_identify for the last namespace fails or if
> nvme_get_features for the last namespace fails."
>
> So we always discard errors for not-the-last namespace, but return an
> error if identify or get_features for the last namespace gets an error.
> Worse, on returning an error, the caller will free the queues and all the
> controller structures, even though the namespaces have been registered as
> devices!  I really didn't think through the error path here, did I?  :-)
>
> So, I would propose that we _always_ discard any errors we hit going through
> the namespace addition loop.  As long as we've been able to set up queues
> and identify the controller, this function should return success.
>
> And I think *that* patch is as simple as adding:
>
>                        list_add_tail(&ns->list, &dev->namespaces);
>        }
> +	res = 0;
>        list_for_each_entry(ns, &dev->namespaces, list)
>                add_disk(ns->disk);
>
> What do you think?

Great idea! Better than waiting for each possible failure to occur and
have a bunch of patches to fix essentially the same problem. :)
