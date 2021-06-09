Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077ABC48BD1
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 11:39:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA02F61364
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 11:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA02F61364
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=3HPYgmK2FrMwoCATGeFmdHOtWse7/Os3qFafOymnpa0=; b=Csp6qFm0TtC55I
	HjgW927BZ7dOeDM72WLAkTgwse6H0uNIoKsPQjdyVvb9YSDmUxB18uv73x3bKGJgzcEvhHEDybB/D
	dpNP7x0dwL24iUwhjHgBAAPQ5IgzCDgfE6SsxFSQUQKrgBx24boVRLEU9nPIGbSmqXnmifEWQHr3A
	N+Cegxe1rhZUub4j9CeG1+0TJDpRwfSzmlMMiBk80SX5O0o+jMgNkzI3o8OLhFFoUq3JdCcPzb4Nl
	tV5A2nVN41ZhbUZzW0u9w8P7W0QnRiw+kfyr13Xrmd8SqFrUkz+pedVc2VmWEI/6/4KdeIzgzBgjL
	oxVpNa/nEyp9L5bxujYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqwXv-00DNiS-Ta; Wed, 09 Jun 2021 11:38:56 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqwVK-00DMwp-36
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 11:36:16 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20210609113609epoutp028a5e3a7ae3fbd2a96d8a0d8a6d100130~G5uEFEjS10063400634epoutp02J
 for <linux-nvme@lists.infradead.org>; Wed,  9 Jun 2021 11:36:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20210609113609epoutp028a5e3a7ae3fbd2a96d8a0d8a6d100130~G5uEFEjS10063400634epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1623238569;
 bh=VCC1ocTa+pfE1YBQEhmF6TG5sDdJYTYPM8fYYtuGelk=;
 h=From:To:Cc:Subject:Date:References:From;
 b=JV7jbfl5gSSQ4cFQs1bhPke2IWmjSNEilyUEeEOka1MlhRH1mUqKtgzOD7S6GilpR
 0uUxZSJ5gMztzLNMa3kKpjzYgI0XstVPKQDChOgs9FInXhyFAQp7OBPy+uCy6IW7UV
 4bZYe2NUuLnL8YcExd5vGhrQhmhMfPrYVtAqZ+pk=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20210609113609epcas5p21235af4b27c4c7e7b253521dc1b2958b~G5uDrE7_v2107321073epcas5p24;
 Wed,  9 Jun 2021 11:36:09 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 A4.BA.09697.9A7A0C06; Wed,  9 Jun 2021 20:36:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20210609105347epcas5p42ab916655fca311157a38d54f79f95e7~G5JEleDmZ1718217182epcas5p4O;
 Wed,  9 Jun 2021 10:53:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210609105347epsmtrp11f28ff6a44abcbac76dab9ce1534baa2~G5JEkus3_1421214212epsmtrp1V;
 Wed,  9 Jun 2021 10:53:47 +0000 (GMT)
X-AuditID: b6c32a4a-64fff700000025e1-44-60c0a7a9df8d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 55.98.08163.BBD90C06; Wed,  9 Jun 2021 19:53:47 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210609105345epsmtip139d160f4a440ad7b08683a6b96ab98c1~G5JC8NJ832853528535epsmtip1B;
 Wed,  9 Jun 2021 10:53:45 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, javier@javigon.com,
 anuj20.g@samsung.com, joshiiitr@gmail.com, Kanchan Joshi
 <joshi.k@samsung.com>
Subject: [LSF/MM/BPF Topic] Towards more useful nvme-passthrough
Date: Wed,  9 Jun 2021 16:20:50 +0530
Message-Id: <20210609105050.127009-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7bCmpu7K5QcSDE7e5rNomvCX2WL13X42
 i5WrjzJZvGs9x2LRefoCk8XR/2/ZLM6/PcxkMenQNUaLvbe0LeYve8puse/1XmYHbo+ds+6y
 ezQvuMPicflsqcemVZ1sHpuX1HtMvrGc0WP3zQY2j74tqxg9Pm+SC+CM4rJJSc3JLEst0rdL
 4MpYtvIWe8EVqYr/6/YyNjBuE+li5OSQEDCRaN91lrWLkYtDSGA3o8TvpkMsEM4nRomeHW+Z
 IJzPjBILDmxnhGl5+fg5VGIXo8Sdk0tZ4Kom7j/O3sXIwcEmoClxYXIpSIOIQJ3E9NOn2EBq
 mAVmMUrsPbaTDSQhLOAg8fvKf7CpLAKqEvc+7mQCsXkFLCX2dT9khdgmLzHz0nd2iLigxMmZ
 T1hAbGagePPW2cwgQyUEWjkkvry/ww7R4CJxcOJuJghbWOLV8S1QcSmJl/1tUHaxxK87R6Ga
 OxglrjfMZIFI2Etc3POXCeQDZqAP1u/ShwjLSkw9tY4JYjGfRO/vJ1DzeSV2zIOxFSXuTXoK
 dbS4xMMZS6BsD4nnM7rAbCGBWImlPzawTmCUn4Xkn1lI/pmFsHkBI/MqRsnUguLc9NRi0wKj
 vNRyveLE3OLSvHS95PzcTYzgNKXltYPx4YMPeocYmTgYDzFKcDArifCWGe5LEOJNSaysSi3K
 jy8qzUktPsQozcGiJM674uHkBCGB9MSS1OzU1ILUIpgsEwenVAPTkg2CpuI3eQI0z5/h+8Ln
 0nN4anTQ4wcNN9V48u9Nu7zJZPak99wPmjyy1OyKJmvr/2TrrW+67sl9pIjNcX7e9XfCVTJ7
 D+j+nKhpKNntHXf6s4bxDI0jW7RerY/JrFu60+C48t7qSM9KzxnfZXQ+yJ9Zd3HO+alcRTJt
 r7TvCS2YsjmFb9GKd8d/bPDW8+xerHRtJxvXksL/L+W6vG9zeXlbzYx+bXHkzr2vgX8733p4
 tIr+vLQvVzs050jzmbf1vjHnqj+3ey59Fsdy9X3honmPrqpvP3zInPmz59XK587lyis+b35e
 /9i+esl6H3vxxE4hwertWg+trs5SOxZ3+b5qdKra4hpJY57d33UUlFiKMxINtZiLihMByGuZ
 CcIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSnO7uuQcSDCY2q1k0TfjLbLH6bj+b
 xcrVR5ks3rWeY7HoPH2ByeLo/7dsFuffHmaymHToGqPF3lvaFvOXPWW32Pd6L7MDt8fOWXfZ
 PZoX3GHxuHy21GPTqk42j81L6j0m31jO6LH7ZgObR9+WVYwenzfJBXBGcdmkpOZklqUW6dsl
 cGUsW3mLveCKVMX/dXsZGxi3iXQxcnJICJhIvHz8nKmLkYtDSGAHo8SVnqUsEAlxieZrP9gh
 bGGJlf+es0MUfWSUuL9zHZDDwcEmoClxYXIpSFxEoIlRYtqu84wgDcwCixgl7tzyArGFBRwk
 fl/5DxZnEVCVuPdxJxOIzStgKbGv+yErxAJ5iZmXvrNDxAUlTs58wgIxR16ieets5gmMfLOQ
 pGYhSS1gZFrFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREc8FpaOxj3rPqgd4iRiYPx
 EKMEB7OSCG+Z4b4EId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZ
 ODilGpgmmJaKZOxRu3hi9yIW4e4l0t7mW6WEY41VNs0uYqidUMlTVdRz6FiSt/eVKVxhNTda
 HXK/zc+rncpXv6fbf51MKqO6WX/elY3cD+3ZpD0OtEZ+X71EftYf1zvnuJzXd769tiO3cnvt
 pu1n2Fxtr/d+6VdlrD2wo/NRtXrRJi2lrdvlrEoyuSbmvusUMVvktydjW6T+DlMpn77D+757
 fbx0VarPtl3M8NmTYzMOszu+vbDDM/3ftWMRn7OftEbwVhnub4jJSpIo0v7wXls5as2kjvvS
 dotDHFb2zfUX+cdtYqm5dpdrruQJF3Hryw5rRRe6CMxysL8iammfv3LOw4srm/c+lI2aZ1Ty
 /+VXCyWW4oxEQy3mouJEAKDvwqDnAgAA
X-CMS-MailID: 20210609105347epcas5p42ab916655fca311157a38d54f79f95e7
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210609105347epcas5p42ab916655fca311157a38d54f79f95e7
References: <CGME20210609105347epcas5p42ab916655fca311157a38d54f79f95e7@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_043614_527652_735A236F 
X-CRM114-Status: GOOD (  16.30  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Background & objectives:
------------------------

The NVMe passthrough interface

Good part: allows new device-features to be usable (at least in raw
form) without having to build block-generic cmds, in-kernel users,
emulations and file-generic user-interfaces - all this take some time to
evolve.

Bad part: passthrough interface has remain tied to synchronous ioctl,
which is a blocker for performance-centric usage scenarios. User-space
can take the pain of implementing async-over-sync on its own but it does
not make much sense in a world that already has io_uring.

Passthrough is lean in the sense it cuts through layers of abstractions
and reaches to NVMe fast. One of the objective here is to build a
scalable pass-through that can be readily used to play with new/emerging
NVMe features.  Another is to surpass/match existing raw/direct block
I/O performance with this new in-kernel path.

Recent developments:
--------------------
- NVMe now has a per-namespace char interface that remains available/usable
  even for unsupported features and for new command-sets [1].

- Jens has proposed async-ioctl like facility 'uring_cmd' in io_uring. This
  introduces new possibilities (beyond storage); async-passthrough is one of
those. Last posted version is V4 [2].

- I have posted work on async nvme passthrough over block-dev [3]. Posted work
  is in V4 (in sync with the infra of [2]).

Early performance numbers:
--------------------------
fio, randread, 4k bs, 1 job
Kiops, with varying QD:

QD      Sync-PT         io_uring        Async-PT
1         10.8            10.6            10.6
2         10.9            24.5            24
4         10.6            45              46
8         10.9            90              89
16        11.0            169             170
32        10.6            308             307
64        10.8            503             506
128       10.9            592             596

Further steps/discussion points:
--------------------------------
1.Async-passthrough over nvme char-dev
It is in a shape to receive feedback, but I am not sure if community
would like to take a look at that before settling on uring-cmd infra.

2.Once above gets in shape, bring other perf-centric features of io_uring to
this path -
A. SQPoll and register-file: already functional.
B. Passthrough polling: This can be enabled for block and looks feasible for
char-interface as well.  Keith recently posted enabling polling for user
pass-through [4]
C. Pre-mapped buffers: Early thought is to let the buffers registered by
io_uring, and add a new passthrough ioctl/uring_cmd in driver which does
everything that passthrough does except pinning/unpinning the pages.

3. Are there more things in the "io_uring->nvme->[block-layer]->nvme" path
which can be optimized.

Ideally I'd like to cover good deal of ground before Dec. But there seems
plenty of possibilities on this path.  Discussion would help in how best to
move forward, and cement the ideas.

[1] https://lore.kernel.org/linux-nvme/20210421074504.57750-1-minwoo.im.dev@gmail.com/
[2] https://lore.kernel.org/linux-nvme/20210317221027.366780-1-axboe@kernel.dk/
[3] https://lore.kernel.org/linux-nvme/20210325170540.59619-1-joshi.k@samsung.com/
[4] https://lore.kernel.org/linux-block/20210517171443.GB2709391@dhcp-10-100-145-180.wdc.com/#t

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
