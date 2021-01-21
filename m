Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B6BC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 02:34:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047732388B
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 02:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047732388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=comcast.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a1wLgwo7JxmXfcU7iMWGUC2xO3Gl2L+SDe5kj0NK+D4=; b=IOAFqhsneDM9Xd
	TV0mIp35tKrKg9lXtlnxn+g/6/KwN1SEziJuNVPO1YSnerku3R/UgS+LH080sOdbHNziXJ+9JyqU9
	VDE8hZWexalECmDbcS9lec1/mKWjqq6YIlWUGh7d+zGS0C/4fOLdrGKBFGzXRb+Sb8XsELbtXwhvF
	nAXZcUPpHWkcr3cfF1K9rCq4/v8030VjjXguMgoogELVRLLkhY7a7esK/7T+02s+Ti5Ktv/09WLSy
	flkAmgeypl1MlI+bugimECf4mbfJXqjTUMLOE0FgH/AJ52skGtUBV2gdL/8CDdRpKrvti1I1rI10+
	kJGyvlKIU5z0aAk6AhxA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2PnE-0003Ap-FC; Thu, 21 Jan 2021 02:33:52 +0000
Received: from resqmta-po-08v.sys.comcast.net
 ([2001:558:fe16:19:96:114:154:167])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2PnB-00036W-SV
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 02:33:51 +0000
Received: from resomta-po-08v.sys.comcast.net ([96.114.154.232])
 by resqmta-po-08v.sys.comcast.net with ESMTP
 id 2PUllgjVWXAgT2PmklPefu; Thu, 21 Jan 2021 02:33:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
 s=20190202a; t=1611196402;
 bh=yMWCqaBMqjsjcburMtOjL4DWtd1iVwfcMyxWwdy6zFg=;
 h=Received:Received:Reply-To:Subject:To:From:Message-ID:Date:
 MIME-Version:Content-Type;
 b=QTlkPSMZePTDr/kwJ8+irxKBT1vFrFKHO5UxNhVosFb+SNFJJY/2A/A8jrXcuBJfB
 8kV9C92kbiJnzWHbFtIZHHB7Z3XxloJnmVsk3zbo5fC/7hfw2koEpSZ+a3Htu1unJ0
 y+vyHDml7JwvZEZF9qNqB7Yzi7caov8+t3jntiTdzSL4jTi+ysAvYxb41EMEFwkhxr
 Ios66NMF9ETeG8E4TCUebzkjWVZSsFGcqOLEyd3kRi2M94krS123przH5T7AUMwWkx
 LmZHokORDo+ldEICPNWVj4ELysBCz2Hzz8y+xe3htplPIkMyMN3CzPo4mM+5EQ3Kyg
 wZFBkVOi44CLw==
Received: from [IPv6:2601:147:c380:23e0:7063:74c9:b089:a00f]
 ([IPv6:2601:147:c380:23e0:7063:74c9:b089:a00f])
 by resomta-po-08v.sys.comcast.net with ESMTPSA
 id 2PmXlgQ4A8b6T2PmelAujW; Thu, 21 Jan 2021 02:33:20 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
Subject: Re: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow;
 use-after-free.
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <f50bc59c-db11-bb44-55be-7b9db1119872@comcast.net>
 <BYAPR04MB49659C0F0F0E11D166B31E0586A40@BYAPR04MB4965.namprd04.prod.outlook.com>
 <a4c75497-d170-1e0f-8608-282231ff3a8e@comcast.net>
 <BYAPR04MB496542BEF594F0380F7D41CF86A20@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Bradley Chapman <chapman6235@comcast.net>
Message-ID: <df46d7ce-ce70-1f43-0efd-7153761bcff0@comcast.net>
Date: Wed, 20 Jan 2021 21:33:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496542BEF594F0380F7D41CF86A20@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210120_213350_149522_2D5F3FB4 
X-CRM114-Status: GOOD (  28.12  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: chapman6235@comcast.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Good evening!

On 1/19/21 10:08 PM, Chaitanya Kulkarni wrote:
> On 1/18/21 10:33 AM, Bradley Chapman wrote:
>> Good afternoon!
>>
>> On 1/17/21 11:36 PM, Chaitanya Kulkarni wrote:
>>> On 1/17/21 11:05 AM, Bradley Chapman wrote:
>>>> [ 2836.554298] nvme nvme1: I/O 415 QID 3 timeout, disable controller
>>>> [ 2836.672064] blk_update_request: I/O error, dev nvme1n1, sector 16350
>>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>>> [ 2836.672072] blk_update_request: I/O error, dev nvme1n1, sector 16093
>>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>>> [ 2836.672074] blk_update_request: I/O error, dev nvme1n1, sector 15836
>>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>>> [ 2836.672076] blk_update_request: I/O error, dev nvme1n1, sector 15579
>>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>>> [ 2836.672078] blk_update_request: I/O error, dev nvme1n1, sector 15322
>>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>>> [ 2836.672080] blk_update_request: I/O error, dev nvme1n1, sector 15065
>>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>>> [ 2836.672082] blk_update_request: I/O error, dev nvme1n1, sector 14808
>>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>>> [ 2836.672083] blk_update_request: I/O error, dev nvme1n1, sector 14551
>>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>>> [ 2836.672085] blk_update_request: I/O error, dev nvme1n1, sector 14294
>>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>>> [ 2836.672087] blk_update_request: I/O error, dev nvme1n1, sector 14037
>>>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>>> [ 2836.672121] nvme nvme1: failed to mark controller live state
>>>> [ 2836.672123] nvme nvme1: Removing after probe failure status: -19
>>>> [ 2836.689016] Aborting journal on device dm-0-8.
>>>> [ 2836.689024] Buffer I/O error on dev dm-0, logical block 25198592,
>>>> lost sync page write
>>>> [ 2836.689027] JBD2: Error -5 detected when updating journal superblock
>>>> for dm-0-8.
>>> Without the knowledge of fs mount/format command I can only suspect that
>>> super
>>> block zeroing issued with write-zeroes request is translated into
>>> REQ_OP_WRITE_ZEROES which controller is not able to process resulting in
>>> the error. This analysis maybe wrong.
>>>
>>> Can you please share following details :-
>>>
>>> nvme id-ns /dev/nvme0n1 -H (we are interested in oncs part here)
>> I ran the requested command against /dev/nvme1n1 (since /dev/nvme0n1
>> works perfectly so far) and here is the result:
> Sorry my bad it suppose to be nvme id-ctrl /dev/nvme0n1 -H

$ nvme id-ctrl /dev/nvme1n1 -H

NVME Identify Controller:
vid       : 0x2263
ssvid     : 0x1d97
sn        : P2002287000000001296
mn        : SPCC M.2 PCIe SSD
fr        : V1.0
rab       : 6
ieee      : 000000
cmic      : 0
   [3:3] : 0     ANA not supported
   [2:2] : 0     PCI
   [1:1] : 0     Single Controller
   [0:0] : 0     Single Port

mdts      : 5
cntlid    : 1
ver       : 10300
rtd3r     : 249f0
rtd3e     : 13880
oaes      : 0x200
   [9:9] : 0x1   Firmware Activation Notices Supported
   [8:8] : 0     Namespace Attribute Changed Event Not Supported

ctratt    : 0
   [5:5] : 0     Predictable Latency Mode Not Supported
   [4:4] : 0     Endurance Groups Not Supported
   [3:3] : 0     Read Recovery Levels Not Supported
   [2:2] : 0     NVM Sets Not Supported
   [1:1] : 0     Non-Operational Power State Permissive Not Supported
   [0:0] : 0     128-bit Host Identifier Not Supported

rrls      : 0
oacs      : 0x7
   [8:8] : 0     Doorbell Buffer Config Not Supported
   [7:7] : 0     Virtualization Management Not Supported
   [6:6] : 0     NVMe-MI Send and Receive Not Supported
   [5:5] : 0     Directives Not Supported
   [4:4] : 0     Device Self-test Not Supported
   [3:3] : 0     NS Management and Attachment Not Supported
   [2:2] : 0x1   FW Commit and Download Supported
   [1:1] : 0x1   Format NVM Supported
   [0:0] : 0x1   Security Send and Receive Supported

acl       : 3
aerl      : 3
frmw      : 0x2
   [4:4] : 0     Firmware Activate Without Reset Not Supported
   [3:1] : 0x1   Number of Firmware Slots
   [0:0] : 0     Firmware Slot 1 Read/Write

lpa       : 0xa
   [3:3] : 0x1   Telemetry host/controller initiated log page Suporrted
   [2:2] : 0     Extended data for Get Log Page Not Supported
   [1:1] : 0x1   Command Effects Log Page Supported
   [0:0] : 0     SMART/Health Log Page per NS Not Supported

elpe      : 63
npss      : 0
avscc     : 0x1
   [0:0] : 0x1   Admin Vendor Specific Commands uses NVMe Format

apsta     : 0
   [0:0] : 0     Autonomous Power State Transitions Not Supported

wctemp    : 354
cctemp    : 363
mtfa      : 0
hmpre     : 16384
hmmin     : 16384
tnvmcap   : 0
unvmcap   : 0
rpmbs     : 0
  [31:24]: 0     Access Size
  [23:16]: 0     Total Size
   [5:3] : 0     Authentication Method
   [2:0] : 0     Number of RPMB Units

edstt     : 5
dsto      : 1
fwug      : 0
kas       : 0
hctma     : 0
   [0:0] : 0     Host Controlled Thermal Management Not Supported

mntmt     : 0
mxtmt     : 0
sanicap   : 0
   [2:2] : 0     Overwrite Sanitize Operation Not Supported
   [1:1] : 0     Block Erase Sanitize Operation Not Supported
   [0:0] : 0     Crypto Erase Sanitize Operation Not Supported

hmminds   : 0
hmmaxd    : 0
nsetidmax : 0
anatt     : 0
anacap    : 0
   [7:7] : 0     Non-zero group ID Not Supported
   [6:6] : 0     Group ID does not change
   [4:4] : 0     ANA Change state Not Supported
   [3:3] : 0     ANA Persistent Loss state Not Supported
   [2:2] : 0     ANA Inaccessible state Not Supported
   [1:1] : 0     ANA Non-optimized state Not Supported
   [0:0] : 0     ANA Optimized state Not Supported

anagrpmax : 0
nanagrpid : 0
sqes      : 0x66
   [7:4] : 0x6   Max SQ Entry Size (64)
   [3:0] : 0x6   Min SQ Entry Size (64)

cqes      : 0x44
   [7:4] : 0x4   Max CQ Entry Size (16)
   [3:0] : 0x4   Min CQ Entry Size (16)

maxcmd    : 0
nn        : 1
oncs      : 0x1d
   [6:6] : 0     Timestamp Not Supported
   [5:5] : 0     Reservations Not Supported
   [4:4] : 0x1   Save and Select Supported
   [3:3] : 0x1   Write Zeroes Supported
   [2:2] : 0x1   Data Set Management Supported
   [1:1] : 0     Write Uncorrectable Not Supported
   [0:0] : 0x1   Compare Supported

fuses     : 0
   [0:0] : 0     Fused Compare and Write Not Supported

fna       : 0x3
   [2:2] : 0     Crypto Erase Not Supported as part of Secure Erase
   [1:1] : 0x1   Crypto Erase Applies to All Namespace(s)
   [0:0] : 0x1   Format Applies to All Namespace(s)

vwc       : 0x5
   [7:3] : 0x2   Reserved
   [0:0] : 0x1   Volatile Write Cache Present

awun      : 0
awupf     : 0
nvscc     : 0
   [0:0] : 0     NVM Vendor Specific Commands uses Vendor Specific Format

nwpc      : 0
   [2:2] : 0     Permanent Write Protect Not Supported
   [1:1] : 0     Write Protect Until Power Supply Not Supported
   [0:0] : 0     No Write Protect and Write Protect Namespace Not Supported

acwu      : 0
sgls      : 0
  [1:0]  : 0     Scatter-Gather Lists Not Supported

mnan      : 0
subnqn    :
ioccsz    : 0
iorcsz    : 0
icdoff    : 0
ctrattr   : 0
   [0:0] : 0     Dynamic Controller Model

msdbd     : 0
ps    0 : mp:3.30W operational enlat:5 exlat:5 rrt:0 rrl:0
           rwt:0 rwl:0 idle_power:- active_power:-

>>> Also for above device what is the value for the queue block write-zeroes
>>>
>>> parameter that is present in the
>>> /sys/block/<nvmeXnY>/queue/write_zeroes_max_bytes ?
>> $ cat /sys/block/nvme1n1/queue/write_zeroes_max_bytes
>> 131584
> So write-zeroes is configured from the setup.
>>> You can also try blkdiscard -z 0 -l 1024 /dev/<nvmeXnY> to see if the
>>> problem is with
>>> write zeroes.
>> # blkdiscard -z -l 1024 /dev/nvme1n1
>> blkdiscard: /dev/nvme1n1: BLKZEROOUT ioctl failed: Device or resource busy
> This is exactly what I thought, we need to add a quirk for this model
> and make sure
> we don't set the write-zeroes support and make blk-lib emulate the
> write-zeroes.

I am ready to take patches for the NVMe driver to test this out - this 
device is not a boot device and I have no data on it that needs to be 
preserved.

>>> Also can you please also try the latest nvme tree branch nvme-5.11 ?
>>>
>> Where do I get that code from? Is it already in the 5.11-rc tree or do I
>> need to look somewhere else? I checked https://github.com/linux-nvme but
>> I did not see it there.
> Here is the link :-git://git.infradead.org/nvme.git
> Branch 5.12.

I tried fetching the entire repo but it was huge and would have taken a 
long time, so I tried to fetch a single branch instead and got this result:

$ git clone --branch 5.12 --single-branch git://git.infradead.org/nvme.git
Cloning into 'nvme'...
warning: Could not find remote branch 5.12 to clone.
fatal: Remote branch 5.12 not found in upstream origin

I haven't compiled any out-of-tree kernel code in a very long time - how 
easy is it to add this code to a kernel tree and compile it into the 
kernel once I've figured out how to get it?

Brad

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
