From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 8 Feb 2018 01:23:00 +0200
Subject: NVMEoF oops on reset
In-Reply-To: <CO2PR04MB2198B265C1EBD138187E1A1D82FC0@CO2PR04MB2198.namprd04.prod.outlook.com>
References: <CO2PR04MB21987F3848378AB2A7BA21B582FD0@CO2PR04MB2198.namprd04.prod.outlook.com>
 <d443433f-5456-a86d-84ce-49afa10f8eb8@mellanox.com>
 <CO2PR04MB2198B265C1EBD138187E1A1D82FC0@CO2PR04MB2198.namprd04.prod.outlook.com>
Message-ID: <ae953130-a5de-7e33-58b8-231a8fb7c7f8@mellanox.com>



On 2/7/2018 10:54 PM, Berck Nash wrote:
> On 02/06/2018 06:06 PM, Max Gurtovoy wrote:
>> On 2/7/2018 12:04 AM, Berck Nash wrote:
>>> We're experiencing an oops whenever we issue an "nvme reset" via the
>>> nvme cli on fabric setups.  Appears to be in the nvme_rdma code.  The
>>> problem occurs on mainline 4.15, as well as on 4.16-nvme (commit
>>> ca5554a696dce37852f6d6721520b4f13fc295c3).
>>
>> please try me patches for fixing the state machine (attached).
>> These should apply over nvme-4.16 but still there is a missing commit
>> from Sagi the I mentioned in the cover letter. So with these 4 patches
>> your test should pass...
> 
> Thanks, but that doesn't seem to be any better.  Loaded all 4 patches
> against nvme-4.16, and got a slightly different crash.  Entire log attached.
> 

I suggest you taking Linus master branch and apply my 3 patches and 
re-test it. nvme-4.16 is not rebased over 4.15.0 IMO.
You might need to fix some stright-forward conflict applying the patches..

I run successfuly a loop with 100 iterations of "nvme reset /dev/nvme0"

BTW, please add more details regarding your setup (I use ConnectX-5 in 
my test connected B2B using IB link layer).


-Max.
