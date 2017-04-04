From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 4 Apr 2017 11:25:41 -0600
Subject: [RFC 4/8] p2pmem: Add debugfs "stats" file
In-Reply-To: <95928b70-0148-7297-8f5e-5031d996bb98@grimberg.me>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-5-git-send-email-logang@deltatee.com>
 <95928b70-0148-7297-8f5e-5031d996bb98@grimberg.me>
Message-ID: <d6dac1a4-8c16-d780-fca5-9cbc4d3e2407@deltatee.com>



On 04/04/17 04:46 AM, Sagi Grimberg wrote:
> 
>> +    p2pmem_debugfs_root = debugfs_create_dir("p2pmem", NULL);
>> +    if (!p2pmem_debugfs_root)
>> +        pr_info("could not create debugfs entry, continuing\n");
>> +
> 
> Why continue? I think it'd be better to just fail it.

Yup, agreed. This should probably also be PTR_ERR as well.

> Besides, this can be safely squashed into patch 1.

Sure, the only real reason I kept it separate was it was authored by
Steve Wise.

Logan
