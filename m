Return-Path: <SRS0=Iqha=GV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0DFC433E9
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 18:35:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59AEB206BE
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 18:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59AEB206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=comcast.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pjJErM73vFOOE58i5dsewFND82YKD/TISZG6Hd3hMLQ=; b=kvjqjQkgrf3Xup
	YXtRMonOVycKULAPOfGbkHn2MxQjL1Q2rO8bqeX5TMRoja7RhQN1s6uZrd5TQRx9uR2I0Ci+78S5v
	CoLWKRWKSaN0j2hXzNI3Fvw3YtTxuaVxQ/w3YheaNCK84/IJ/Sr42KDQ58sU3yGhMbYZnuZGsuU+P
	fVfalRdY5Yu9YAnbt/np6opZF1hcypjJs/zuqXSFpdkR4IntvA/EAqAcz3unvYNNh0oK0lwEMkc0g
	37Nzw2ajlg8nUWUYGa4dhO8yp3AoM4Xj46sXOqbexfDkoMBgX+gf3rTVMktmqST5r9lCpMoeDPu/o
	ifFNQnoOX3Od3SgvTYXw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1ZMi-0002Oh-GO; Mon, 18 Jan 2021 18:35:00 +0000
Received: from resqmta-po-01v.sys.comcast.net ([96.114.154.160])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1ZMe-0002Lw-3X
 for linux-nvme@lists.infradead.org; Mon, 18 Jan 2021 18:34:58 +0000
Received: from resomta-po-19v.sys.comcast.net ([96.114.154.243])
 by resqmta-po-01v.sys.comcast.net with ESMTP
 id 1ZGclJIxNKqmE1ZLVlAzMI; Mon, 18 Jan 2021 18:33:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
 s=20190202a; t=1610994825;
 bh=wRYVYN9kt8d3GJ43fgv9pt/EP57d102uGrlugHbL8yA=;
 h=Received:Received:Reply-To:Subject:To:From:Message-ID:Date:
 MIME-Version:Content-Type;
 b=XWzEwV79thuE9EYZm8IQqKot+ebNWXXXnVWLAtVY5RYkl9+wlAALg1x1/fmYk4rGN
 lH/ouQ0Ias69H+42NG4YpDLuuYDJbqbNqURZbGWR6WpAQvtUS7BBdXBaQf7TmXF69O
 gEEn7W20Xi3TYq26b8OGSgiS+SBw+kONdlLLFQCCqAiTe7CuMO0C/3RraN2EGpo9Wm
 kfG2TzHsrm8Td2SW7i+4+aMAjGsDX0Z2eQkC9NU/6DNuRi58rtyl0RcwEG6GUtjuXF
 3W+lkhhIXW1j54+doNglp95yTVV1hSXgxE9jalgug2V5U1JegkGm7IxA7dMGsivYFv
 3h2jddqt/9Pxg==
Received: from [IPv6:2601:147:c380:23e0:935a:5445:9b03:bad3]
 ([IPv6:2601:147:c380:23e0:935a:5445:9b03:bad3])
 by resomta-po-19v.sys.comcast.net with ESMTPSA
 id 1ZLTl6hLY6FP11ZLTlaqki; Mon, 18 Jan 2021 18:33:44 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
Subject: Re: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow;
 use-after-free.
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <f50bc59c-db11-bb44-55be-7b9db1119872@comcast.net>
 <BYAPR04MB49659C0F0F0E11D166B31E0586A40@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Bradley Chapman <chapman6235@comcast.net>
Message-ID: <a4c75497-d170-1e0f-8608-282231ff3a8e@comcast.net>
Date: Mon, 18 Jan 2021 13:33:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49659C0F0F0E11D166B31E0586A40@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210118_133456_217730_4524E21D 
X-CRM114-Status: GOOD (  20.91  )
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

Good afternoon!

On 1/17/21 11:36 PM, Chaitanya Kulkarni wrote:
> On 1/17/21 11:05 AM, Bradley Chapman wrote:
>> [ 2836.554298] nvme nvme1: I/O 415 QID 3 timeout, disable controller
>> [ 2836.672064] blk_update_request: I/O error, dev nvme1n1, sector 16350
>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>> [ 2836.672072] blk_update_request: I/O error, dev nvme1n1, sector 16093
>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>> [ 2836.672074] blk_update_request: I/O error, dev nvme1n1, sector 15836
>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>> [ 2836.672076] blk_update_request: I/O error, dev nvme1n1, sector 15579
>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>> [ 2836.672078] blk_update_request: I/O error, dev nvme1n1, sector 15322
>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>> [ 2836.672080] blk_update_request: I/O error, dev nvme1n1, sector 15065
>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>> [ 2836.672082] blk_update_request: I/O error, dev nvme1n1, sector 14808
>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>> [ 2836.672083] blk_update_request: I/O error, dev nvme1n1, sector 14551
>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>> [ 2836.672085] blk_update_request: I/O error, dev nvme1n1, sector 14294
>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>> [ 2836.672087] blk_update_request: I/O error, dev nvme1n1, sector 14037
>> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>> [ 2836.672121] nvme nvme1: failed to mark controller live state
>> [ 2836.672123] nvme nvme1: Removing after probe failure status: -19
>> [ 2836.689016] Aborting journal on device dm-0-8.
>> [ 2836.689024] Buffer I/O error on dev dm-0, logical block 25198592,
>> lost sync page write
>> [ 2836.689027] JBD2: Error -5 detected when updating journal superblock
>> for dm-0-8.
> Without the knowledge of fs mount/format command I can only suspect that
> super
> block zeroing issued with write-zeroes request is translated into
> REQ_OP_WRITE_ZEROES which controller is not able to process resulting in
> the error. This analysis maybe wrong.
> 
> Can you please share following details :-
> 
> nvme id-ns /dev/nvme0n1 -H (we are interested in oncs part here)

I ran the requested command against /dev/nvme1n1 (since /dev/nvme0n1 
works perfectly so far) and here is the result:

NVME Identify Namespace 1:
nsze    : 0x1dcf32b0
ncap    : 0x1dcf32b0
nuse    : 0x1dcf32b0
nsfeat  : 0
   [2:2] : 0     Deallocated or Unwritten Logical Block error Not Supported
   [1:1] : 0     Namespace uses AWUN, AWUPF, and ACWU
   [0:0] : 0     Thin Provisioning Not Supported

nlbaf   : 0
flbas   : 0
   [4:4] : 0     Metadata Transferred in Separate Contiguous Buffer
   [3:0] : 0     Current LBA Format Selected

mc      : 0
   [1:1] : 0     Metadata Pointer Not Supported
   [0:0] : 0     Metadata as Part of Extended Data LBA Not Supported

dpc     : 0
   [4:4] : 0     Protection Information Transferred as Last 8 Bytes of 
Metadata Not Supported
   [3:3] : 0     Protection Information Transferred as First 8 Bytes of 
Metadata Not Supported
   [2:2] : 0     Protection Information Type 3 Not Supported
   [1:1] : 0     Protection Information Type 2 Not Supported
   [0:0] : 0     Protection Information Type 1 Not Supported

dps     : 0
   [3:3] : 0     Protection Information is Transferred as Last 8 Bytes 
of Metadata
   [2:0] : 0     Protection Information Disabled

nmic    : 0
   [0:0] : 0     Namespace Multipath Not Capable

rescap  : 0
   [6:6] : 0     Exclusive Access - All Registrants Not Supported
   [5:5] : 0     Write Exclusive - All Registrants Not Supported
   [4:4] : 0     Exclusive Access - Registrants Only Not Supported
   [3:3] : 0     Write Exclusive - Registrants Only Not Supported
   [2:2] : 0     Exclusive Access Not Supported
   [1:1] : 0     Write Exclusive Not Supported
   [0:0] : 0     Persist Through Power Loss Not Supported

fpi     : 0x80
   [7:7] : 0x1   Format Progress Indicator Supported
   [6:0] : 0     Format Progress Indicator (Remaining 0%)

dlfeat  : 1
   [4:4] : 0     Guard Field of Deallocated Logical Blocks is set to 0xFFFF
   [3:3] : 0     Deallocate Bit in the Write Zeroes Command is Not Supported
   [2:0] : 0x1   Bytes Read From a Deallocated Logical Block and its 
Metadata are 0x00

nawun   : 0
nawupf  : 0
nacwu   : 0
nabsn   : 0
nabo    : 0
nabspf  : 0
noiob   : 0
nvmcap  : 0
nsattr  : 0
nvmsetid: 0
anagrpid: 0
endgid  : 0
nguid   : 00000000000000000000000000000000
eui64   : 0000000000000000
LBA Format  0 : Metadata Size: 0   bytes - Data Size: 512 bytes - 
Relative Performance: 0 Best (in use)

> 
> Also for above device what is the value for the queue block write-zeroes
> 
> parameter that is present in the
> /sys/block/<nvmeXnY>/queue/write_zeroes_max_bytes ?

$ cat /sys/block/nvme1n1/queue/write_zeroes_max_bytes
131584

> 
> You can also try blkdiscard -z 0 -l 1024 /dev/<nvmeXnY> to see if the
> problem is with
> write zeroes.

# blkdiscard -z -l 1024 /dev/nvme1n1
blkdiscard: /dev/nvme1n1: BLKZEROOUT ioctl failed: Device or resource busy

> 
> Also can you please also try the latest nvme tree branch nvme-5.11 ?
> 

Where do I get that code from? Is it already in the 5.11-rc tree or do I 
need to look somewhere else? I checked https://github.com/linux-nvme but 
I did not see it there.

Brad

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
