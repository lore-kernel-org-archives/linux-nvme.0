From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 25 Jan 2018 22:14:47 +0900
Subject: [PATCH 0/2] nvme-cli: add support for an abort command with
 documentation
In-Reply-To: <54e145b5-1518-89ab-61d3-21edd9d44655@broadcom.com>
References: <1516796682-31793-1-git-send-email-minwoo.im.dev@gmail.com>
 <20180124123141.t4gtx6fvzgei2rei@linux-x5ow.site>
 <98552e25-112b-da7a-6ee8-b046c6a54c18@gmail.com>
 <20180124130315.g7i3yk73avo7wh66@linux-x5ow.site>
 <6f273f10-f805-0f55-425e-e36e38796cd4@gmail.com>
 <54e145b5-1518-89ab-61d3-21edd9d44655@broadcom.com>
Message-ID: <0f38a5d1-10bc-d187-e68f-7844c4c7582f@gmail.com>

Hi James,

On 01/25/2018 02:26 AM, James Smart wrote:
> On 1/24/2018 5:15 AM, Minwoo Im wrote:
>> Or.. Is there any cases that breaks behavior of kernel by an abort
>> command from user space?
>>
> 
> Is it possible yes. Is it simple, no.?? Depends on what the command is 
> and when.? You may confuse a transport which uses aborts - and you're 
> also mandating the transport peek into the pass-through command to check 
> for abort so that is can honor the # of outstanding aborts supported by 
> the controller.
> 
> I agree with Johannes. this is an ugly thing to do . The first question 
> I had is - how do you even know what the command and its CID value is ? 
> Also, many devices won't actually even do aborts.
> 
> -- james
> 

I totally agree with you. I really appreciate your comments.
I thought abort command has nothing to do with behavior of kernel, but
CID is assigned by kernel when issuing an command to device.

Thanks again.
