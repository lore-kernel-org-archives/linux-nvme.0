From: hch@lst.de (Christoph Hellwig)
Date: Tue, 4 Dec 2018 16:04:03 +0100
Subject: [PATCH 02/13] nvme-pci: use atomic bitops to mark a queue enabled
In-Reply-To: <1ad65e6d-8b42-6f8e-8eb7-0b28b04e5dd4@grimberg.me>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-3-hch@lst.de>
 <1ad65e6d-8b42-6f8e-8eb7-0b28b04e5dd4@grimberg.me>
Message-ID: <20181204150403.GA3630@lst.de>

On Mon, Dec 03, 2018@04:54:15PM -0800, Sagi Grimberg wrote:
>
>> @@ -2173,6 +2157,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>>     	if (nr_io_queues == 0)
>>   		return 0;
>> +	
>> +	clear_bit(NVMEQ_ENABLED, &adminq->flags);
>>   
>
> This is a change of behavior, looks correct though as we can fail
> nvme_setup_irqs after we freed the admin vector. Needs documentation 
> though..

I have a hard time parsing the above, can you point to where the problem
is?
