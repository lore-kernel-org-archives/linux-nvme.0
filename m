Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B93EC76196
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 04:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:CC:To:From
	:Subject:Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2qEpzSyqDmIGiGp2FQO5QgMythFwEOYJ2vLtjUxh+nw=; b=JdT27wnn1V1Y4ftbADgiGSlOvm
	532LNjVViCPNVnUchce6C9/KfE8qEJ0cPpgnblRgRa5kBXjMsOrIyuSeUEI5cAerJv7htJ5ZNItZ1
	135FSRU2NqgH40I5eZnsn0SJw4YR3S5KMlfOar9XfnZubAnuaK2WWEJExcY5TYh7gBA5AGTohHrUt
	vzx+6YXDMBQ3AJVYIaCWSVWGMSSdQq71Jd2YVy81D2WmTaJWWgIFUGNQC4IG5zzb2fQ/3F6FwqdhC
	4dHelDBiNYmypntKWjhkGKcjDmxkPySI8/10vfXw7saZZBTnGGNKNaVeHGe+LRMhrHvxdXz5M3tut
	GkYpvt8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkH01-006Hu4-2K;
	Thu, 06 Apr 2023 04:13:25 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkGzx-006HtG-1Z
	for linux-nvme@lists.infradead.org;
	Thu, 06 Apr 2023 04:13:23 +0000
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230406041312epoutp029a02e3759178ef209d91b46c5c668d42~TPTb2U-4s3082330823epoutp02d
	for <linux-nvme@lists.infradead.org>; Thu,  6 Apr 2023 04:13:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230406041312epoutp029a02e3759178ef209d91b46c5c668d42~TPTb2U-4s3082330823epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1680754392;
	bh=2qEpzSyqDmIGiGp2FQO5QgMythFwEOYJ2vLtjUxh+nw=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=pWizU0dx2IO9vYySiM54FI0t3O4bNH/KYNZ5/ZWKHmSxkNZWS/reNeois1q8FyfOf
	 LiOk8Ly3CdIGbmlF8hKxP4sXW/MU/whiqBolszeaelsobL5SStTRPtVATkpUuchiIi
	 pros7a+DqMEvZkLpPYOOEDQI2ARrhouS0yOF8K6w=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20230406041312epcas2p4f3f4eaf5fda96aee208eaef018d52f63~TPTbqc1C51946519465epcas2p4f;
	Thu,  6 Apr 2023 04:13:12 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.91]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4PsSlq281Vz4x9QJ; Thu,  6 Apr
	2023 04:13:11 +0000 (GMT)
X-AuditID: b6c32a46-a4bff70000006d16-02-642e46d7a15a
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	C0.18.27926.7D64E246; Thu,  6 Apr 2023 13:13:11 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [RFC v3 1/1] nvme: add passthrough error logging opt-in
From: Minwoo Im <minwoo.im@samsung.com>
To: "alan.adamson@oracle.com" <alan.adamson@oracle.com>, Pankaj Raghav
	Partha Sarathy <p.raghav@samsung.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <3c11b233-82cc-0ab3-c099-1d6f43e4e1d5@oracle.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230406041310epcms2p1a4eb5e5201450bcf092cc1a38ae81a8b@epcms2p1>
Date: Thu, 06 Apr 2023 13:13:10 +0900
X-CMS-MailID: 20230406041310epcms2p1a4eb5e5201450bcf092cc1a38ae81a8b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTQve6m16KwcWD3BZ7+k8xWaxcfZTJ
	YtKha4wW85c9Zbf4vLSF3WLd6/csDmwe5+9tZPHYtKqTzWPzknqP3Tcb2Dw+Pr3F4tG3ZRVj
	AFtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0BlK
	CmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DC
	hOyMQ12vWQq+clWsOSjRwPiHo4uRk0NCwETi8tsNjF2MXBxCAjsYJSa3tQM5HBy8AoISf3cI
	g9QIC7hIzP3WwgISFhKQl/jxygAirCnxbvcZVhCbTUBdomHqKxYQW0QgT+LKk6XMIDazwBZG
	iUW3pCFW8UrMaH/KAmFLS2xfvpURxOYUsJNov72BCSKuIfFjWS8zhC0qcXP1W3YY+/2x+YwQ
	tohE672zUDWCEg9+7oaKS0nsnz8Xyq6WaDj+DGpmhcSv9w+g6s0lft/fDXYzr4CvxKP7u8Dq
	WQRUJRbf7WWFqHGReLX/HgvE/fIS29/OYQZ5nRno3/W79EFMCQFliSO3oCr4JDoO/2WH+XDH
	vCdQW5UlPh46BLVVUmL5pddsEK0eEmsvsk5gVJyFCOVZSFbNQli1gJF5FaNYakFxbnpqsVGB
	ETxek/NzNzGCE6OW2w7GKW8/6B1iZOJgPMQowcGsJMKr2qWVIsSbklhZlVqUH19UmpNafIjR
	FOjJicxSosn5wNScVxJvaGJpYGJmZmhuZGpgriTOK217MllIID2xJDU7NbUgtQimj4mDU6qB
	6ShLxKYL6/5Kl0yXjliav/6XqZPLugIZjvIp5orbMs2YN/GdfHyU79QbsSPHxfq3TlaX1NqV
	9uDMLj5TDr7MFK53rjPvbIiZwvM41dHOySpoXdU6q2sHd7Dt0L7yU71tc0XizGmFvEpaquvP
	vWjxLWTnyUutfe07S/bhjpbaClunXFXWlxO26vOwBB47pzQ/SodjigUrY5qdlKFJkuG/rSu9
	ipPW7Zwm8TTLuaRmQvbuWLZbKfFzDivYlS84806JccqSZrmFcw30Vf4fPG3O9W6H2wnDd6t3
	xF5yERPd7rso4oVAVuru3+cZomLSp++Xz/1spRp5+1z0k/NBpp+/OKs9fKWkX1d58Emute42
	JZbijERDLeai4kQAQ1O4uhUEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230403083443eucas1p225993f889610c6c070dcb24e232aa526
References: <3c11b233-82cc-0ab3-c099-1d6f43e4e1d5@oracle.com>
	<20230331221823.2806192-1-alan.adamson@oracle.com>
	<20230331221823.2806192-2-alan.adamson@oracle.com>
	<20230403082613.owr5wshccoy2uw4z@blixen>
	<CGME20230403083443eucas1p225993f889610c6c070dcb24e232aa526@epcms2p1>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230405_211322_384205_2759C08E 
X-CRM114-Status: GOOD (  24.66  )
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
Reply-To: minwoo.im@samsung.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> On Behalf Of
> alan.adamson@oracle.com
> Sent: Thursday, April 6, 2023 7:35 AM
> To: Pankaj Raghav <p.raghav@samsung.com>
> Cc: linux-nvme@lists.infradead.org; kbusch@kernel.org; hch@lst.de;
> sagi@grimberg.me
> Subject: Re: [RFC v3 1/1] nvme: add passthrough error logging opt-in
>
>
> On 4/3/23 1:26 AM, Pankaj Raghav wrote:
> > On Fri, Mar 31, 2023 at 03:18:23PM -0700, Alan Adamson wrote:
> >> Commit d7ac8dca938c ("nvme: quiet user passthrough command errors") disabled
> error
> >> logging for user passthrough commands.  This commit adds the ability to opt-in
> >> to passthrough error logging.
> >>
> >> To enable passthrough error logging:
> >>          echo 1 > /sys/class/nvme/nvme0/passthrough_logging
> > passthrough_logging is a bit misleading as it doesn't indicate it is
> > going to log only passthrough errors. `passthrough_error_logging` is a bit
> > verbose but it is more apt for what this sysfs entry is doing. Maybe
> > an abbreviation for passthrough_error_logging?
>
> Since we are looking at only opting in to passthrough admin commands,
> how about we call it:
>
> /sys/class/nvme/nvme0/pt_admin_error_logging

I would make `passthrough` short to `passthu` as it looks like we don't use
`pt` as a short for passthrough in drivers/nvme/[host|target].

