From: m@bjorling.me (=?UTF-8?B?TWF0aWFzIEJqw7hybGluZw==?=)
Date: Thu, 16 Apr 2015 15:29:47 +0200
Subject: [PATCH 2/5 v2] blk-mq: Support for Open-Channel SSDs
In-Reply-To: <1429184091.16771.60.camel@x220>
References: <1429101284-19490-1-git-send-email-m@bjorling.me>		
 <1429101284-19490-3-git-send-email-m@bjorling.me>	
 <1429175408.16771.45.camel@x220> <552F8D84.8030504@bjorling.me>
 <1429184091.16771.60.camel@x220>
Message-ID: <552FB94B.2090603@bjorling.me>

On 04/16/2015 01:34 PM, Paul Bolle wrote:
> On Thu, 2015-04-16@12:23 +0200, Matias Bj?rling wrote:
>> On 04/16/2015 11:10 AM, Paul Bolle wrote:
>>> A few things I spotted (while actually fiddling with 3/5).
>>
>> Thanks. I'll fix them up.
>
> Please note that just using #ifdef instead of #if is not all that's
> needed. See, I had some fun playing whack-a-mole with warnings and
> errors showing up in the "CONFIG_BLK_DEV_NVM is not set" case (because I
> was looking into things outside of this series that I don't understand).
>
> After adding the changes pasted at the end of this message (which I gave
> almost no thought whatsoever) I ran into:
>      block/blk-mq.c: In function ?blk_mq_init_rq_map?:
>      block/blk-mq.c:1473:22: error: invalid application of ?sizeof? to incomplete type ?struct nvm_per_rq?
>         cmd_size += sizeof(struct nvm_per_rq);
>                            ^
>
> Then I admitted defeat.
>
> Have fun with your turn of that game.

Thanks. Nothing like a good whack-a-mole. I've fixed it up in the master at:

   https://github.com/OpenChannelSSD/linux.git

Keith, for the nvme driver, I've packed everything neatly into a #ifdef, 
so it looks the same as with the #ifdef integrity. It should have been 
like that from the start.
