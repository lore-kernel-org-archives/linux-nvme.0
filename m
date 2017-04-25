From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Tue, 25 Apr 2017 09:20:00 +0800
Subject: [PATCH] nvme: avoid connecting to the same subsystem from the
 same path gain.
In-Reply-To: <20170424145842.GA32128@infradead.org>
References: <1493040417-15680-1-git-send-email-guanjunxiong@huawei.com>
 <20170424145842.GA32128@infradead.org>
Message-ID: <4e371196-36af-a389-a1a2-bdac1bb70e21@huawei.com>



On 2017/4/24 22:58, Christoph Hellwig wrote:
> On Mon, Apr 24, 2017@09:26:57PM +0800, Guan Junxiong wrote:
>> From: Junxiong Guan <guanjunxiong at huawei.com>
>>
>> Current code has the defect that we will get more /dev/nvme#n#
>> generated in the /dev node if we execute the same connect command
>> with nvme-cli tools more than once.
> 
> That's not a bug, it's a a feature.
> 
> .
Hi ,Christoph:
   What's the benefits of this feature? If we execute the following cmd
10 times, it will generate 10 character and at least 20 block devices.

   nvme connect -r rdma -a 192.168.2.1 -n tgtnqn -q hostnqn
   10 times repeating, then list nvme devices:
   nvme list
   we get a flood of nvme devices now.
