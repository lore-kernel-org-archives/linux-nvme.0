Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA08BC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 09:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p0ZlcEzOmh/ydalvLnOpLOlkx/qyF5DNIPEx1qZBrPs=; b=1VMKenYdrbLh/QLOHbPvxcDTuk
	wiTrDVbfGlj/3jDgr01Q6zO1LJIsz/Vr7JDj+PE0HhsasQWF0X09aay0Z/t++qipibmeKVNd/nTcA
	WebrrVOSxZ+RKAq0GOCZjhWNl657cyuxdDIkFWpQuwWix9oXGZY/37a2COiHOuinAVoNjioVzjQqb
	yWy+aOR4Mkzs5YY1hYOE4nvqp9h1MjVnrNU8JavY92tZyasEfVXGiI+tjhsZGq80RQGvRotC2647d
	Of5CHMOtq76Fk7LPsQ1qcv/2+Yxpa9YL9DFGks/nk2aEtY8g2oph5eDYDf7BWHb8YEj6ZEUIrpw2y
	o5qHOpVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzanw-0075nw-87; Fri, 10 Jun 2022 09:19:44 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzans-0075li-Io
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 09:19:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 6562DB831C8;
	Fri, 10 Jun 2022 09:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20543C3411C;
	Fri, 10 Jun 2022 09:19:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YlJTWccV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1654852773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p0ZlcEzOmh/ydalvLnOpLOlkx/qyF5DNIPEx1qZBrPs=;
	b=YlJTWccV31WUh+THqnnmoQsWbfRYTbMmPYXb59YQmr/IYHluQ1m4VxpETT6L/UXL5ve3Sf
	7WH54gysPMpRLkofMS7VZm9bhmDetT/hxJ0DSE+INaNVhN0iK4o2KrCDcP15f7L41De/Zx
	8L7Gz0btKrczHnmBHZ43tHLjukR9pAY=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 06324467 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
	Fri, 10 Jun 2022 09:19:33 +0000 (UTC)
Date: Fri, 10 Jun 2022 11:19:31 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "R, Monish Kumar" <monish.kumar.r@intel.com>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"alan.adamson@oracle.com" <alan.adamson@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>, Yi Zhang <yi.zhang@redhat.com>,
	Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was: Re:
 [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
 observed during blktests]
Message-ID: <YqMMo2Dv9SZRtR7B@zx2c4.com>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <Ykyf5Zuz1W8yHhNY@zx2c4.com>
 <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
 <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
 <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com>
 <YqG/pybFg0P5yQ9a@zx2c4.com>
 <20220610061449.GD24331@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220610061449.GD24331@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_021941_151547_E32B4F75 
X-CRM114-Status: GOOD (  13.77  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Christoph,

On Fri, Jun 10, 2022 at 08:14:49AM +0200, Christoph Hellwig wrote:
> That leaves us with two plausible theories:
> 
>  - the problems could be due to an earlier firmware version or
>    ASIC stepping
>  - the problems are due to the thunderbolt attachment

Right, that seems like the set of variance we're dealing with. If it's a
firmware version issue, then we revert because people can update? Or can
we quirk firmware version numbers too? If it's ASIC stepping, I guess we
need to quirk that. And likewise thunderbolt, but that seems more
awkward to quirk around, because afaik, it all just appears as PCIe?

> Monish and Jason, can you please send me the output of nvme id-ctrl
> /dev/nvmeX (where /dev/nvmeX is the actual device number)?

NVME Identify Controller:
vid       : 0x144d
ssvid     : 0x144d
sn        : <redacted>
mn        : Samsung SSD 970 EVO Plus 2TB            
fr        : 2B2QEXM7
rab       : 2
ieee      : 002538
cmic      : 0
mdts      : 9
cntlid    : 0x4
ver       : 0x10300
rtd3r     : 0x30d40
rtd3e     : 0x7a1200
oaes      : 0
ctratt    : 0
rrls      : 0
cntrltype : 0
fguid     : 
crdt1     : 0
crdt2     : 0
crdt3     : 0
nvmsr     : 0
vwci      : 0
mec       : 0
oacs      : 0x17
acl       : 7
aerl      : 3
frmw      : 0x16
lpa       : 0x3
elpe      : 63
npss      : 4
avscc     : 0x1
apsta     : 0x1
wctemp    : 358
cctemp    : 358
mtfa      : 0
hmpre     : 0
hmmin     : 0
tnvmcap   : 2000398934016
unvmcap   : 0
rpmbs     : 0
edstt     : 35
dsto      : 0
fwug      : 0
kas       : 0
hctma     : 0x1
mntmt     : 356
mxtmt     : 358
sanicap   : 0
hmminds   : 0
hmmaxd    : 0
nsetidmax : 0
endgidmax : 0
anatt     : 0
anacap    : 0
anagrpmax : 0
nanagrpid : 0
pels      : 0
domainid  : 0
megcap    : 0
sqes      : 0x66
cqes      : 0x44
maxcmd    : 0
nn        : 1
oncs      : 0x5f
fuses     : 0
fna       : 0x5
vwc       : 0x1
awun      : 1023
awupf     : 0
icsvscc     : 1
nwpc      : 0
acwu      : 0
ocfs      : 0
sgls      : 0
mnan      : 0
maxdna    : 0
maxcna    : 0
subnqn    : 
ioccsz    : 0
iorcsz    : 0
icdoff    : 0
fcatt     : 0
msdbd     : 0
ofcs      : 0
ps    0 : mp:7.50W operational enlat:0 exlat:0 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:- active_power:-
ps    1 : mp:5.90W operational enlat:0 exlat:0 rrt:1 rrl:1
          rwt:1 rwl:1 idle_power:- active_power:-
ps    2 : mp:3.60W operational enlat:0 exlat:0 rrt:2 rrl:2
          rwt:2 rwl:2 idle_power:- active_power:-
ps    3 : mp:0.0700W non-operational enlat:210 exlat:1200 rrt:3 rrl:3
          rwt:3 rwl:3 idle_power:- active_power:-
ps    4 : mp:0.0050W non-operational enlat:2000 exlat:8000 rrt:4 rrl:4
          rwt:4 rwl:4 idle_power:- active_power:-

Jason

