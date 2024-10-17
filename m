Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65532D374A1
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 14:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iOBcp7aP5HM3dUP7gIM6o5ClGnNylDTBCP21YgwbY7M=; b=gf5itDOKRoYODzJEC19T2E5AfV
	guuwVvxuJpGFNFG6KAfveJnlbQ+O0enj3BtXVRz09/PjkFKpwPj9hRU4KbjNUNjeGXyFX+tmxpgP5
	DtJXRnYbXBdKd5vgKGMHsDCiwoZPAto0Llayjn37N26fEg8Q/nHCAGpYfLJqXgdHGbakx9DeNKS4t
	5O3odYGJHvcshNHUg1bmGdYpTyDwMi2g0i1yzYkSJdwGzhbvD7R9d35txc4/LUmbbgPPim23TxYST
	dtHMlGO4J55dNkJS0e20Cuelgj2e+sIf3hOZCk6BEF3Ou1BID9Fqh2G+/9oAXV9+TnSJ1BOjxwQJL
	zBlPJDPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Rbm-0000000F8WD-0Nj2;
	Thu, 17 Oct 2024 14:36:10 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1RbX-0000000F8RS-1gR7
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 14:36:02 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241017143545epoutp04b70970a7a640ed46b3025e26051fb9d3~-RC3kFrYQ0806808068epoutp04c
	for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 14:35:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241017143545epoutp04b70970a7a640ed46b3025e26051fb9d3~-RC3kFrYQ0806808068epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729175745;
	bh=iOBcp7aP5HM3dUP7gIM6o5ClGnNylDTBCP21YgwbY7M=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=pKQCveuTncWs1SOA5k8eGF3hD7wZDpxs1lfR73qGsgPBvsNVhuOSz6o61Bm6Viqe3
	 StLjt7LiE12U3+th9MpVXGv7ViwnhiEwIykQ2MjXW9+WM+dHVdyz45/FD8bqjxIz1i
	 0UvL5neSzL/nydTxchup44T4a6B2Jin7vFSehm8A=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241017143545epcas5p3d270ce2c807b777f642577ca836ad739~-RC3FlkKJ1086510865epcas5p3P;
	Thu, 17 Oct 2024 14:35:45 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XTr3g4C2gz4x9Pt; Thu, 17 Oct
	2024 14:35:43 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8F.A4.09420.FB021176; Thu, 17 Oct 2024 23:35:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241017143542epcas5p21ab337a0e4d4e5b47195aecf2c0527ad~-RC02BwEq2057020570epcas5p2w;
	Thu, 17 Oct 2024 14:35:42 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241017143542epsmtrp15897660aaeef9a2881d6ec4b840f8403~-RC01MACr1088810888epsmtrp1G;
	Thu, 17 Oct 2024 14:35:42 +0000 (GMT)
X-AuditID: b6c32a49-33dfa700000024cc-04-671120bfae7c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	0E.E7.18937.EB021176; Thu, 17 Oct 2024 23:35:42 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241017143539epsmtip2d862c9c441a66f8fcf68dfe632b0e2f3~-RCxtBgXX3101031010epsmtip2T;
	Thu, 17 Oct 2024 14:35:39 +0000 (GMT)
Message-ID: <8be869a7-c858-459a-a34b-063bc81ce358@samsung.com>
Date: Thu, 17 Oct 2024 20:05:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
	martin.petersen@oracle.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
	bvanassche@acm.org, asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20241015055006.GA18759@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxTZxTG9957aS9g3eVDeIEwups4o+OjZdBdmBQTiF7nQogjTt0y7OCu
	xZbS9QMUTKgWmRLQWoxiwdAxhAkKoaClgpsDCRBkuMGmdsJwthqBgsPFqQyzlqLjv9855zl5
	znnfHBz1r2SH4jlyNaOUi2Qkywe73Lt+XdQPXD8xr0MbTtU0XQZU8/hxFlX2sgOjpnvnAXXq
	8XOUmj20gFF3rlkRqrvOgFDnm/sQavbwTxhVfVqHUPZWI0rdv/uETRl6fgPUyVOHAHXV9i7V
	fXUQo2obHGyqsf8lQrVMz2HUyGK/FzVirGFvCqJHx7bRVuM4mx6ZaMPo0WENbW46yqLN8wY2
	3V5fTHfd0bLovxw2jJ77/lcWfayjCdA3TNddxaEi+on5LdpsdyLpb+6WbpQwomxGyWXkWXnZ
	OXJxErnt48yUzHgBjx/FT6DeJ7lyUS6TRKZ+lB61OUfmWp/k5otkGlcqXaRSkTHCjco8jZrh
	SvJU6iSSUWTLFHGKaJUoV6WRi6PljDqRz+PFxruEe6QSZ3mJl6IrcN/5B72IFpiJMuCNQyIO
	2n/RIW72J7oAtJ0sKgM+Lp4H8PQ5Pft1oNM1s1516CvvAk/BCmB7iw7zBE4Avysd8nKrOIQQ
	NjT+vMQYsRY6quZZnrwfHDxjx9y8hoiAf9iq2G4OIHhw7p+KJU0gQULH1PCSA0pMoLDfdA91
	F1AiGNrsta5hcZxFrIc3KzXutDcRCS/d0iMeSQS0OGtQdy8kLN7wxtk5zDN2Kjyor17mADjV
	38H2cCh8dLx0maVw8s/JZc0B2Nl+zMvDyVD7720vty/q8m29EuPxWg0rFuxL40CCA4+U+nvU
	b8MJg2O5Mxjeq6pfZhoarWMsz1tdAPDF9a9RPeAaVzyLccWWxhXrGP93NgGsCYQwClWumFHF
	K/hypuD1h2fl5ZrB0nVs2NoJxicfR/cABAc9AOIoGcgxlHHE/pxs0f5CRpmXqdTIGFUPiHf9
	zwk0dE1Wnuu85OpMflwCL04gEMQlvCfgk8Gc6cNns/0JsUjNSBlGwShf9SG4d6gWEYCQ2JnE
	tA9WLbC27+8bL9/RmXy/Fw8YS9lruiD4hJX2mSTi2QI+2t2Gp9ZGch/NdliKpb1p0vAjvoaZ
	zNUg5sPSxBzviqJpY+PU8MzuvkvnLhpyYgfqRkoCj2YV+vpWBzF+4tjcsKorB7bfXNy689PF
	4JACXnJLmza4KOGNE9b8XfPPkvf341+GFvh1vWMJpVdJKs78KCzR336ge5H0VIiBmoUh0jYQ
	1LbXGRQRlSrbVZ4YFmbJl4Q/N9Xhnb+3HPzq4g5h/brRTQ31KTJ/m84ZIBmoMu2J7Lc8zLim
	XjuYocrY8o3pW+HfDV8UtnYyPUmOfQ99AnYi6NMt1s+LNbdITCUR8TegSpXoPzkoOE+mBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7bCSvO4+BcF0g6XLdC3mrNrGaLH6bj+b
	Rde/LSwWrw9/YrSY9uEns8W7pt8sFjcP7GSy2LNoEpPFytVHmSzetZ5jsZg9vZnJ4sn6WcwW
	j+98ZreYdOgao8WUaU2MFntvaVvs2XuSxWL+sqfsFsuP/2OyWPf6PYvF+b/HWS3Oz5rD7iDm
	cfmKt8fOWXfZPc7f28jicflsqcemVZ1sHps+TWL32Lyk3mP3zQY2j49Pb7F4vN93lc2jb8sq
	Ro8zC44AJU9Xe3zeJOex6clbpgD+KC6blNSczLLUIn27BK6Mtz0trAW7RSpWPjvM1MC4SaCL
	kZNDQsBEYsLkO4xdjFwcQgLbGSWefnrMCpEQl2i+9oMdwhaWWPnvOZgtJPCaUeLZXCEQm1fA
	TmLZ8otg9SwCqhJPZ3xig4gLSpyc+YQFxBYVkJe4f2sGWK+wgIHE+++9YDUiAkoST1+dBVvM
	LHCPWWLdnE5WiCvWMEps/TUfrIMZ6IpbT+YzdTFycLAJaEpcmFwKEuYU0JHYen0CE0SJmUTX
	1i5GCFteYvvbOcwTGIVmIbljFpJJs5C0zELSsoCRZRWjaGpBcW56bnKBoV5xYm5xaV66XnJ+
	7iZGcHrQCtrBuGz9X71DjEwcjIcYJTiYlUR4J3XxpgvxpiRWVqUW5ccXleakFh9ilOZgURLn
	Vc7pTBESSE8sSc1OTS1ILYLJMnFwSjUwzZxaKrrgjbSnzJGH1U7r+Z+63oiverwv5NjTx+v2
	b37oM9M2Vj1sN8NhvZmfAkOFjWc+rLQri1/b1cc+4Upf2P6KGYvPtXzi4W+Uz760/lLU45r1
	61+tMd3Ndeb1NdXp57bKpj2VlZRRLBOxLuku/G0i03Uz+5yI/48zkY7fHbNLt/a3Ok8p/iTh
	rOciac18SuPLq29PpF6aq9pLnpxxc4dp1T/DiMrci+zH814fCIsPOPzGndmqVEH4yU9GhlNS
	cySUJ12X5d18aSXPmgqvm5UvrMTNavWf/PvGtvB5yAFPpbqP75IYr/5dcyxwb/beGLYqt6OG
	83kS3gqKFi6azWwYcHifn+ffySGhZZu9lFiKMxINtZiLihMBemXmH34DAAA=
X-CMS-MailID: 20241017143542epcas5p21ab337a0e4d4e5b47195aecf2c0527ad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240930182052epcas5p37edefa7556b87c3fbb543275756ac736
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
	<20240930181305.17286-1-joshi.k@samsung.com> <20241015055006.GA18759@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_073555_813190_AEA761F2 
X-CRM114-Status: GOOD (  23.50  )
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

Seems per-I/O hints are not getting the love they deserve.
Apart from the block device, the usecase is when all I/Os of VM (or 
container) are to be grouped together or placed differently.

Per-IO hints are fine-granular (enough for userspace to build 
per-process/vm/file/whatever etc.) and add the flexibility we have 
lacked so far.
As for conflict, I doubt if that exists. Please see below:

> 2) A per-I/O interface to set these temperature hint conflicts badly
> with how placement works in file systems.  If we have an urgent need
> for it on the block device it needs to be opt-in by the file operations
> so it can be enabled on block device, but not on file systems by
> default.  This way you can implement it for block device, but not
> provide it on file systems by default.  If a given file system finds
> a way to implement it it can still opt into implementing it of course.

Why do you see this as something that is so different across filesystems 
that they would need to "find a way to implement"?
Both per-file and per-io hints are supplied by userspace. Inode and 
kiocb only happen to be the mean to receive the hint information.
FS is free to use this information (iff it wants) or simply forward this 
down.

Per-file hint just gets stored (within inode) without individual FS 
involvement. Per-io hint follows the same model (i.e., it is set by 
upper layer like io_uring/aio) and uses kiocb to store the hint. It does 
not alter the stored inode hint value!

After patch #3, filesystems have both per-file and per-io information 
available. And as before, they can use that hint info (from kiocb or 
inode) and/or simply forward.

The generic code (like fs/direct-io.c, fs/iomap/direct-io.c etc.,) 
already forwards the incoming hints, without any intelligence.
And we need just that because with user-passed hints, the onus of 
intelligence is on the userspace. This is how hints work on 
xfs/ext4/btrfs files at this point.

The owner of the file (filesystem, block, whatever) can still use the 
incoming hints to do any custom/extra feature. Either from inode or from 
kiocb depending on what information (per-file or per-io hint) it finds 
more useful for that custom feature. For example, F2FS is using 
per-inode information to do something custom and that part has not been 
changed by these patches.

Overall, I do not see the conflict. It's all user-driven. No?

For the currently uncommon case when FS decides to generate its own 
hints (as opposed to userspace hint consumer/forwarder), it can directly 
put the hint value in bio.

