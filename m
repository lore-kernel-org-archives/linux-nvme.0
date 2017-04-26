From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Wed, 26 Apr 2017 17:34:13 +0800
Subject: [PATCH] nvme: avoid connecting to the same subsystem from the
 same path gain.
In-Reply-To: <4e371196-36af-a389-a1a2-bdac1bb70e21@huawei.com>
References: <1493040417-15680-1-git-send-email-guanjunxiong@huawei.com>
 <20170424145842.GA32128@infradead.org>
 <4e371196-36af-a389-a1a2-bdac1bb70e21@huawei.com>
Message-ID: <d8a5b465-3ba6-dfb5-4f1a-df2ddad35cec@huawei.com>



On 2017/4/25 9:20, Guan Junxiong wrote:
> 
> Hi ,Christoph:
>    What's the benefits of this feature? If we execute the following cmd
> 10 times, it will generate 10 character and at least 10 block devices.
> 
>    nvme connect -r rdma -a 192.168.2.1 -n tgtnqn -q hostnqn
>    10 times repeating, then list nvme devices:
>    nvme list
>    we get a flood of nvme devices now.
> 
> 
> 
Hi, Christoph:
   I am looking forward to your response of this feature.
Thanks a lot.
