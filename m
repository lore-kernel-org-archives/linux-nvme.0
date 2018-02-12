From: Berck.Nash@wdc.com (Berck Nash)
Date: Mon, 12 Feb 2018 21:43:14 +0000
Subject: NVMEoF oops on reset
References: <CO2PR04MB21987F3848378AB2A7BA21B582FD0@CO2PR04MB2198.namprd04.prod.outlook.com>
 <d443433f-5456-a86d-84ce-49afa10f8eb8@mellanox.com>
 <CO2PR04MB2198B265C1EBD138187E1A1D82FC0@CO2PR04MB2198.namprd04.prod.outlook.com>
 <ae953130-a5de-7e33-58b8-231a8fb7c7f8@mellanox.com>
Message-ID: <CO2PR04MB2198864F0345E207A947D43582F70@CO2PR04MB2198.namprd04.prod.outlook.com>

On 02/07/2018 04:24 PM, Max Gurtovoy wrote:
> On 2/7/2018 10:54 PM, Berck Nash wrote:
>> On 02/06/2018 06:06 PM, Max Gurtovoy wrote:
>>> On 2/7/2018 12:04 AM, Berck Nash wrote:
>>>> We're experiencing an oops whenever we issue an "nvme reset" via the
>>>> nvme cli on fabric setups.  Appears to be in the nvme_rdma code.  The
>>>> problem occurs on mainline 4.15, as well as on 4.16-nvme (commit
>>>> ca5554a696dce37852f6d6721520b4f13fc295c3).
>>>
>>> please try me patches for fixing the state machine (attached).
>>> These should apply over nvme-4.16 but still there is a missing commit
>>> from Sagi the I mentioned in the cover letter. So with these 4 patches
>>> your test should pass...
>>
>> Thanks, but that doesn't seem to be any better.  Loaded all 4 patches
>> against nvme-4.16, and got a slightly different crash.  Entire log attached.
>>
> 
> I suggest you taking Linus master branch and apply my 3 patches and
> re-test it. nvme-4.16 is not rebased over 4.15.0 IMO.
> You might need to fix some stright-forward conflict applying the patches..
> 
> I run successfuly a loop with 100 iterations of "nvme reset /dev/nvme0"
> 
> BTW, please add more details regarding your setup (I use ConnectX-5 in
> my test connected B2B using IB link layer).

Thanks, we tried your 3 patches applied against stable 4.15.1.  That 
worked much better for the happy-path, normal reset case.  However, it 
looks like sometimes we're getting an error on the identify controller 
command, and in that case, we get the same crash.  We'll need to 
investigate why the identify failure, but obviously the driver shouldn't 
crash on the error.

We're using a ConnectX-4 as the initiator.

Please find the kernel log attached.

Berck
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: nvme_rdma_oops_4.15.1+.txt
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180212/9b253660/attachment-0001.txt>
