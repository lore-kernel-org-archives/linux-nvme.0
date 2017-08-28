From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Mon, 28 Aug 2017 18:15:26 +0800
Subject: I/O Errors due to keepalive timeouts with NVMf RDMA
In-Reply-To: <61e877ac-200c-c393-0a41-b1684a10f8c7@linux.vnet.ibm.com>
References: <20170710102049.GF5105@linux-x5ow.site>
 <77c7d11c-bd67-8663-cc10-da3af8bfcd22@grimberg.me>
 <20170710113353.GG5105@linux-x5ow.site>
 <ebc9dccc-ce68-f5f3-3e24-372b2cd7f44b@grimberg.me>
 <20170710115003.GH5105@linux-x5ow.site>
 <4df0a8a8-168f-06c4-6112-dfd2893d6e06@grimberg.me>
 <20170711085204.GA7846@linux-x5ow.site>
 <a0656ff3-f2b9-4580-bf6f-8206cd73b680@grimberg.me>
 <20170714112554.GF8497@linux-x5ow.site>
 <f02a02e6-f2c3-c07d-bca5-e0eac587a8a0@linux.vnet.ibm.com>
 <20170816081639.GB29784@infradead.org>
 <61e877ac-200c-c393-0a41-b1684a10f8c7@linux.vnet.ibm.com>
Message-ID: <035a3445-3b98-0629-356a-31f93eee42f1@huawei.com>



On 2017/8/17 0:19, Guilherme G. Piccoli wrote:
> On 08/16/2017 05:16 AM, Christoph Hellwig wrote:
>> We're having discussions in the working group to allow I/O commands
>> to reset the keepalive timer.  Stay tuned.
>>
> 
> Cool, thanks Christoph!
Thanks too.
BTW, does "I/O commands" refer to any IO capsule a host/target sends/receives,
or refer to adding new commands into the NVMf Spec?

Thanks
