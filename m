From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 9 May 2019 05:51:38 +0000
Subject: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>
 <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <cfa4d48d-ce13-0ace-cf5c-a3d0d1f4cca7@gmail.com>
 <SN6PR04MB4527FAD8076A5A5610F6B66786300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <c86fe09e-9964-123a-bc17-e9b9e6a80856@gmail.com>
 <SN6PR04MB45273CEE5FE1DDF38677980F86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <CAA7jztfU+AdUHp5xo8ssjgvXiBFBXJt0PyQTNA8VQU-T-SpKQA@mail.gmail.com>
Message-ID: <SN6PR04MB4527510BF05DCBF27E0B6D2F86330@SN6PR04MB4527.namprd04.prod.outlook.com>

On 5/6/19 4:24 PM, Minwoo Im wrote:
>>>> I wasn't clear enough.
>>>>
>>>> It doesn't check for the return value for now. What needs to happen is :-
>>>>
>>>> 1. Get rid of the variable strings which are not part of the discovery
>>>>        log page entries such as Generation counter.
>>>> 2. Validate each log page entry content.
>>>
>>> Question again here.
>>> Do you mean that log page entry contents validation should be in bash
>>> level instead of *.out comparison?
>>
>> It has *out level comparison.
> 
> I'm not sure I have got what you really meant.  Please correct me if I'm wrong
> here ;)
> 
> First of all, removal of variable values in the result of the
> discovery get log page
> looks great to me also.  Maybe those variable values are able to be replaced
> a fixed value like port does (replace port value via sed command to X).
> 
> But, it also depends on the outout of the nvme-cli, not return value.
> Anyway, let's discuss about it with Keith also because he discussed it with me
> few weeks ago,I think.
> 
>>>
>>>> 3. Check the return value.
>>>
>>> nvme-cli is currently returning value like:
>>>      > 0 :   failed with nvme status code (but the actual value may not be
>>> the same with status)
>>>      == 0 : done successfully
>>>      < 0 :   failed with -errno
>>>
>>> But, ( > 0) case may be removed from nvme-cli soon due to [1] discuss.
>>> Anyway, if nvme-cli is going to return 0 for both cases: success, error
>>> with nvme status, then test case is going to be hard to check the error
>>> status by a return value.
>>
>> This should not happen as it will break existing scripts which are
>> written on the top the nvme-cli in past few years.
> 
> Agreed.  But, please refer the following comment below ;)
> 
>>
>>     It should be with output string parsing which
>>> would be great if it's going to be commonized.
>>>
>> No, we cannot rely on the output string as this problem is a good example.
>>
>> I'm not sure returning == 0 for error case is a good idea. Checking
>> return value prevents us from writing unstable testcases which are bases
>> on the text output and allow us to modify tools as specification moves
>> forward.
> 
> Please refer a discussion on https://github.com/linux-nvme/nvme-cli/pull/489
> Keith and I had a discussion about the return value of the program itself.
> The nvme status value is composed of 16 bits value, by the way, the actual
> return value of the program is in 8bits(signed) which means it's not
> able to carry
> the actual nvme status value out of the program.
Isn't this unsigned ? as pointed out by Keith ?

$ cat a.c
int main(void)
{
	return -1;
}
$ gcc a.c -o a
$ ./a
$ echo $?
255

May be I'm missing something here ?
> 
> If you have any idea about it, Please let me know.  By the way, I really do
> agree with what you mentioned about the return value.  If it's possible,
> I would like to too :)

How about we instead of returning the NVMe Status we map the NVMe Status 
of the program to the error code and in-turn return that error code ?

The above is true only when command is successfully submitted from the
program i.e. no errno is set by any library calls and failed in the 
completion queue entry with NVMe Status != NVME_SC_SUCCESS.

For your reference In kernel we already do this detailed mapping where :-

1. Please refer to the drivers/nvme/target/core.c file where we map the
errno_to_nvme_status(), the reverse mapping of that function can be done 
with nvme_status_to_errno(). Of course you will have to add more cases 
and do in-detail reverse error mapping from NVMe status to errno and
return that errno.
2. nvme_error_status() we map NVMe Status to block layer status.
3. blk_status_to_errno() we map the block layer status to the errno.

With the help of 1, 2 and 3 you can reverse map the NVMe Status to errno
and add that mapper function for nvme-cli which will be consistent with 
the kernel NVMe status to errno mapping.

Now you might find some cases where you cannot map all the status codes 
to errno and for those default cases you may end up using something like 
EIO, this is still better way than having to return 0.
> 
>>
>>> [1] https://github.com/linux-nvme/nvme-cli/pull/492
>>>
>>
> 
