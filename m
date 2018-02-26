From: mb@lightnvm.io (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Mon, 26 Feb 2018 19:33:42 +0100
Subject: [PATCH V3 00/19] lightnvm: pblk: implement 2.0 support
In-Reply-To: <49DA8C17-0960-4EBF-9FA7-364DE5EAF405@cnexlabs.com>
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
 <93f1a727-55bf-ff7c-bc05-70cc9f5f9f27@lightnvm.io>
 <87859168-A64E-4FF6-9F7E-174A903704D0@cnexlabs.com>
 <398381af-7c17-4e57-1d07-f50051c05430@lightnvm.io>
 <49DA8C17-0960-4EBF-9FA7-364DE5EAF405@cnexlabs.com>
Message-ID: <8ef84882-b847-2b2a-7e63-a7203e8531ce@lightnvm.io>

On 02/26/2018 07:27 PM, Javier Gonzalez wrote:
>> On 26 Feb 2018,@19.24, Matias Bj?rling <mb@lightnvm.io> wrote:
>>
>> On 02/26/2018 07:21 PM, Javier Gonzalez wrote:
>>>> On 26 Feb 2018,@19.19, Matias Bj?rling <mb@lightnvm.io> wrote:
>>>>
>>>> On 02/26/2018 02:16 PM, Javier Gonz?lez wrote:
>>>>> # Changes since V2:
>>>>> Apply Matias' feedback:
>>>>>   - Remove generic nvm_id identify structure.
>>>>>   - Do not remap capabilities (cap) to media and controlled capabilities
>>>>>     (mccap). Instead, add a comment to prevent confusion when
>>>>>     crosschecking with 2.0 spec.
>>>>>   - Change maxoc and maxocpu defaults from 1 block to the max number of
>>>>>     blocks.
>>>>>   - Re-implement the generic geometry to use nvm_geo on both device and
>>>>>     targets. Maintain nvm_common_geo to make it easier to copy the common
>>>>>     part of the geometry (without having to overwrite target-specific
>>>>>     fields, which is ugly and error prone). Matias, if you still want to
>>>>>     get rid of this, we can do it.
>>>>
>>>> I do, the variables should go directly in nvm_geo. Thanks.
>>> Ok. Is the rest ok with you?
>> I'll go through it when the rebase is posted. Most of the patches is
>> dependent on the first patch.
> 
> As it is now, it will be basically %s/geo->c.X/geo->X/g. If you can look
> at the first patch now, I can put all comments in a single version more,
> instead of going through one extra cycle...
> 
> 

Also the variable dev_geo -> geo. I'm good with just getting the updated 
version before posting the full patch set again.
