From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 31 Mar 2017 15:23:26 -0600
Subject: [RFC 1/8] Introduce Peer-to-Peer memory (p2pmem) device
In-Reply-To: <cb102386-0314-a3a3-ed44-b42debdf1512@codeaurora.org>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-2-git-send-email-logang@deltatee.com>
 <cb102386-0314-a3a3-ed44-b42debdf1512@codeaurora.org>
Message-ID: <7158f2e8-2016-f398-e77f-0fcbe6cb41dd@deltatee.com>



On 31/03/17 12:49 PM, Sinan Kaya wrote:
> Don't you need to clean up the p->pool here.

See Patch 7 in the series.

>> +	put_device(&p->dev);
>> +}
>> +EXPORT_SYMBOL(p2pmem_unregister);
>> +
> 
> I don't like the ugliness around the switch port to be honest. 
> 
> Going to whitelist/blacklist looks simpler in my opinion.

What exactly would you white/black list? It can't be the NIC or the
disk. If it's going to be a white/black list on the switch or root port
then you'd need essentially the same code to ensure they are all behind
the same switch or root port. So you could add a white/black list on top
of the current scheme but you couldn't get rid of it.

Our original plan was to just punt the decision to userspace but we had
pushback on that at LSF.

Thanks,

Logan
