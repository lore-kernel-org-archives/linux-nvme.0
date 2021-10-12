Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46311C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 08:28:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E562760E74
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 08:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E562760E74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fuckner.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7TGvOf6RAUXE5Nsc4RmNrnbC5QUO5jUTsZTe5VkUefs=; b=QQavSeECFMjYcZ
	sYS/Io3Gs2GXib0BE2KdM0kQWcnlMNhzPOtgDZM33IdYCjW77A1cVBd0mb2y3qV3x8KF+llbvfeIm
	/tSsBAyx4lQOnCD7GipXkB7MtWdN7ugWAvYOqVsatwYOJBTJKSQJ8rILslcDfl668MLocIrn80KyB
	wFZymP/bloz8qU6QP8/XNNl1PbuuIKaJLKS2yIXChd3FIY3HaFr5M0uzsOpkdLMfx8PWICpohBHDT
	1v1iynChe2bbN+7GpgA27YvKNsi8unlyi0sYvwDUz2ukqHDTUEULtTlK+BHfp41+5lfOOrUrv5RZO
	U6/8zACLWGjkwbCsqZVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maD97-00C0JK-Lb; Tue, 12 Oct 2021 08:28:25 +0000
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maD94-00C0IA-Ip
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 08:28:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1634027298;
 s=strato-dkim-0002; d=fuckner.net;
 h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=QIXOfTqU+ViwwJuNnwQi4Zt/DaSA6DiXt9vqXawri0I=;
 b=qJgI7/PCxkNLNmm3HU4cM7ljZLPqxUg3sYIdSnRuxpK0B2dbiiIXl/TxVgB27RSRC3
 pYbc9s75JnAabqyEcx9wuK7dZN+VZMLO56t+s0x9DEWGWjvzBrepdE9pPOPTGURbGpMX
 WXScko/t3O1Qrwbmst1Jc2fX4i/aNB3Ctl36g7obH+LtFWoXaiTBZNAUv1+UyDN4Mzz+
 8JntvzpFdrpCdwzybXV3CC99xgLAMNRQEoGzANWbLm9uPRQ7qoP3c0rOVq2LNS87hrmC
 9E+UNp6QCm+oIkXX3zFgxdh0Ajbzc0/dKZeEwDhqW7iPtA8m4lJoVsUtGI8n+JLIPYNW
 vAgw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":IWUHfUGtd9+6EujMWHx57N4dWae4bmTbIPWLqRDxdxMSR21kQd9enlO2mnkCSHWyJK8ZpINU"
X-RZG-CLASS-ID: mo00
Received: from [194.175.217.179] by smtp.strato.de (RZmta 47.33.8 AUTH)
 with ESMTPSA id 6017e9x9C8SIvUL
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 12 Oct 2021 10:28:18 +0200 (CEST)
Message-ID: <50968b55-e25a-cf60-36a2-b330d5362024@fuckner.net>
Date: Tue, 12 Oct 2021 10:28:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Namespaces on MZQL2960HCJR-00A07
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <34244386.3221623.1633769595569@com4.strato.de>
 <20211011191249.GB635062@dhcp-10-100-145-180.wdc.com>
From: Michael Fuckner <michael@fuckner.net>
In-Reply-To: <20211011191249.GB635062@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_012822_868715_2DED4BA1 
X-CRM114-Status: GOOD (  13.02  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,


On 11.10.21 21:12, Keith Busch wrote:
> On Sat, Oct 09, 2021 at 10:53:15AM +0200, Michael Fuckner wrote:
> The long options should use "--" rather than just the single "-". I'm
> unsure if that changes the parsing, though.
doesn't make a difference:
nvme attach-ns /dev/nvme7 -c 6 -n 1
NVMe status: Controller List Invalid: The controller list provided 
contains invalid controller ids(0x211c)


> > Was the namespace attached to cntlid 0x6 prior to the detach/delete part
> of the test?
this is a similar system also all drives connected directly to EPYC 
CPUs. This drive still has the default ns:

test220:~ # nvme id-ctrl /dev/nvme1
NVME Identify Controller:
vid       : 0x144d
ssvid     : 0x144d
sn        : S64HNE0R902239
mn        : SAMSUNG MZQL23T8HCLS-00A07
fr        : GDC5302Q
rab       : 2
ieee      : 002538
cmic      : 0
mdts      : 9
cntlid    : 0x6
ver       : 0x10400
rtd3r     : 0x7a1200
rtd3e     : 0x7a1200
oaes      : 0x300
ctratt    : 0x80
rrls      : 0
cntrltype : 1
fguid     :
crdt1     : 0
crdt2     : 0
crdt3     : 0
oacs      : 0x5f
acl       : 7
aerl      : 3
frmw      : 0x17
lpa       : 0xe
elpe      : 63
npss      : 1
avscc     : 0x1
apsta     : 0
wctemp    : 353
cctemp    : 356
mtfa      : 0
hmpre     : 0
hmmin     : 0
tnvmcap   : 3840755982336
unvmcap   : 0
rpmbs     : 0
edstt     : 35
dsto      : 1
fwug      : 0
kas       : 0
hctma     : 0
mntmt     : 0
mxtmt     : 0
sanicap   : 0x3
hmminds   : 0
hmmaxd    : 0
nsetidmax : 0
endgidmax : 0
anatt     : 0
anacap    : 0
anagrpmax : 0
nanagrpid : 0
pels      : 0
sqes      : 0x66
cqes      : 0x44
maxcmd    : 256
nn        : 32
oncs      : 0x5f
fuses     : 0
fna       : 0x4
vwc       : 0x6
awun      : 1023
awupf     : 7
icsvscc     : 1
nwpc      : 0
acwu      : 0
sgls      : 0
mnan      : 0
subnqn    : nqn.1994-11.com.samsung:nvme:PM9A3:2.5-inch:S64HNE0R902239
ioccsz    : 0
iorcsz    : 0
icdoff    : 0
fcatt     : 0
msdbd     : 0
ofcs      : 0
ps    0 : mp:25.00W operational enlat:70 exlat:70 rrt:0 rrl:0
           rwt:0 rwl:0 idle_power:4.00W active_power:-
ps    1 : mp:8.00W operational enlat:70 exlat:70 rrt:1 rrl:1
           rwt:1 rwl:1 idle_power:4.00W active_power:-
test220:~ #

> 
> When you created the namespace, did the output confirm the namespace was
> created as nsid 1?
yes, I can create and delete namespaces, but I can not attach them:

test220:~ # nvme create-ns /dev/nvme7 -s 26214387 -c 26214387 -b 4096
create-ns: Success, created nsid:1
test220:~ # nvme attach-ns /dev/nvme7 -n 1 -c 0x6
NVMe status: Controller List Invalid: The controller list provided 
contains invalid controller ids(0x211c)
test220:~ # nvme delete-ns /dev/nvme7 -n 1
delete-ns: Success, deleted nsid:1
test220:~ #


> Is the namespace attached to any other controllers? You have to specify
> multi-controller enabled when creating the namespace in that case.
no, just 4 lanes from CPU to NVMe Drive.

Hope this helps,
  Michael!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
