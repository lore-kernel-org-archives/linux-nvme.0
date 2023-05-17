Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBABC77B7F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 10:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EMMsT4WvkgqIKI0pmzWb/0/zW50yz6q81OjErKncAjw=; b=vH0THCVBCS5Z/nzsT0F+qLJJ7S
	mnESPmzmcS/NW7WGahZRc3NMUr8GiyhxoraUtUbHFLc6HaBWaJNGCzhaExDfKU4w7p4c9/qxCEDCc
	zSJLz0/A1z9jUoNzog3OaaJAU83kRd1GLjljDvvGG/py0c5aZkXYFHyCxtel6qR3457tSxhzHZJjo
	oQhLCft/I2+6KupPa/1yzfU7lptJr7edQTg8OX9rF5NwIZmUD6hQ5OXTNTZVlbRkVrC0zMe0OAD+u
	SF4OugWEZOHQwo/XmIMoSQ34lbaasMe6cWZnpJExSCs3JSVVZkItoz8DLmRzlWaxB6hTHkMnQDKp7
	h/M3Wdqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzEWs-009RWY-2z;
	Wed, 17 May 2023 10:37:10 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzEWo-009RUD-1G
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 10:37:09 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230517103659epoutp0202935c4f214dc133464c43a3514b2ccd~f5-PIo_xW1385713857epoutp02h
	for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 10:36:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230517103659epoutp0202935c4f214dc133464c43a3514b2ccd~f5-PIo_xW1385713857epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1684319819;
	bh=EMMsT4WvkgqIKI0pmzWb/0/zW50yz6q81OjErKncAjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OX1nJu35UiZ79WQhyWtgUAuWOdaaAqQbQbk/gh132GSk7Y+cef6WccyUkBGGeIg/v
	 9aFsvK9lRGc7PoOZlg85zAe0pObtzxbRAQuXYREc0/wQTz8Hd9Gnhutp8g3btqni/W
	 qRCKDMJjXvwzDbX99iRybtJhXPNzbp9PHbUGGrss=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20230517103659epcas5p2c9c27720008b171356498475eab77328~f5-O5WTfR0808408084epcas5p2j;
	Wed, 17 May 2023 10:36:59 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4QLqKk2Jmgz4x9Pp; Wed, 17 May
	2023 10:36:58 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	90.22.54880.A4EA4646; Wed, 17 May 2023 19:36:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20230517103657epcas5p34671066feb44ca15179e3e3fd25aeba4~f5-NML9JS2644026440epcas5p3B;
	Wed, 17 May 2023 10:36:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230517103657epsmtrp2f4cddec5d09ff77dcc4346072e1cf3d6~f5-NLhKbL3074730747epsmtrp2y;
	Wed, 17 May 2023 10:36:57 +0000 (GMT)
X-AuditID: b6c32a49-b21fa7000001d660-f4-6464ae4ae4e4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	DE.7D.28392.94EA4646; Wed, 17 May 2023 19:36:57 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230517103656epsmtip1504e7582bd8dfbe16a6b64c7247a8b48~f5-L_l-Am2953429534epsmtip1E;
	Wed, 17 May 2023 10:36:56 +0000 (GMT)
Date: Wed, 17 May 2023 16:03:56 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH for-next 1/2] io_uring/cmd: add cmd lazy tw wake helper
Message-ID: <20230517103346.GA15743@green245>
MIME-Version: 1.0
In-Reply-To: <65514f94-ac70-08df-a866-fe73f95037fd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmhq7XupQUg45Wbos5q7YxWqy+289m
	sXL1USaLd63nWCwmHbrGaLH3lrbF/GVP2S3WvX7P4sDhsXPWXXaP8/c2snhcPlvqsWlVJ5vH
	5iX1HrtvNrB5fN4kF8AelW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ib
	aqvk4hOg65aZA3SSkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQv
	XS8vtcTK0MDAyBSoMCE7o73vAnNBg2FFa8dT5gbGJu0uRk4OCQETiUtdW1i7GLk4hAR2M0qs
	vXGMHcL5xCjxet4JZgjnM6PE7pkPGWFaXj/YxQpiCwnsYpSYvdcUougZo8SMnWfYQBIsAqoS
	L77PYepi5OBgE9CUuDC5FCQsIqAt8fr6IXYQm1lgPqPE6cfcILawgLfEo8svmEFsXgFdifvX
	F7BB2IISJ2c+YQGxOQVsJXb82QJmiwooSxzYdpwJZK+EwFIOiVMNL1kgjnORWPdiLtShwhKv
	jm9hh7ClJD6/28sGYSdLXJp5jgnCLpF4vOcglG0v0XqqnxniuAyJO3O3M0LYfBK9v5+A/SIh
	wCvR0SYEUa4ocW/SU1YIW1zi4YwlrBAlHhK7VvJBgmQ7k8TLmVsYJzDKzULyziwkGyBsK4nO
	D02sELa8RPPW2cyzgEYxC0hLLP/HAWFqSqzfpb+AkW0Vo2RqQXFuemqxaYFhXmo5PLqT83M3
	MYLTq5bnDsa7Dz7oHWJk4mA8xCjBwawkwhvYl5wixJuSWFmVWpQfX1Sak1p8iNEUGFMTmaVE
	k/OBCT6vJN7QxNLAxMzMzMTS2MxQSZxX3fZkspBAemJJanZqakFqEUwfEwenVAMTh+kZpja9
	FdM95LLvvfBeHnSx7v7JYzFZAooztXrdDlXOlGDcv2zvoWvZF6WF1vxdJLaEe+rEzOMKvL6r
	F1idZYg3Wv1DKHSGQnxwiZ2rEkP6p/aghta553euNJ0TtVC0lXtCbXNYkVjwx2cx+/t2eC/M
	f6TC+Vr/8Yaoj4ckdxY/UV9nz/2+NUHsw5m5EhXZaw9oZWvuXawjLP6++oFHkk/d9AfeEY9F
	pi3NMZ6w2/iXCNvClLPrXF4f1wt8bHpx+bGr35fmX5Q/cVZJJvG6OmfIr59Fh8uitz2xvVP+
	UGDygYhly6bE7272PnVk36mSE43aBzbq91TM0FmvNFHDcsOXefc3Xrh9j01Qevfjz0osxRmJ
	hlrMRcWJAIsP5tc4BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJTtdzXUqKQesiTYs5q7YxWqy+289m
	sXL1USaLd63nWCwmHbrGaLH3lrbF/GVP2S3WvX7P4sDhsXPWXXaP8/c2snhcPlvqsWlVJ5vH
	5iX1HrtvNrB5fN4kF8AexWWTkpqTWZZapG+XwJXRvOMha8FEvYrd07ezNjBu0Ohi5OSQEDCR
	eP1gF2sXIxeHkMAORonLB96wQSTEJZqv/WCHsIUlVv57zg5R9IRR4u7cCUwgCRYBVYkX3+cA
	2RwcbAKaEhcml4KERQS0JV5fPwRWzywwn1Hi5ZfbrCAJYQFviUeXXzCD2LwCuhL3ry9ggxi6
	nUli0qtd7BAJQYmTM5+wgNjMAmYS8zY/ZAZZwCwgLbH8HwdEWF6ieetssDmcArYSO/5sASsX
	FVCWOLDtONMERqFZSCbNQjJpFsKkWUgmLWBkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpec
	n7uJERxNWlo7GPes+qB3iJGJg/EQowQHs5IIb2BfcooQb0piZVVqUX58UWlOavEhRmkOFiVx
	3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTP2FnjwN5d6113hnhC4rmiJ6LjeK+X1M4aHYGy3x
	Mo8/6DP6f4xTdmN7Nm91NK/fpyMRU4J/3XxaIpyx1aNh4b9483xzOxnuuZ46ko2r3n/S8nt3
	8fnDfTqrajvPzKmt97PsiK9YLLKpa47VgYVyt++++Z2ls+Nr4OnTzHa3Kyf7ymzdYLn2/i+9
	K0smbn+z54TI9xU7ttxaPV/byNDf6O8j1egNmxVyzifErz7OdPDwQf+FeRwcaz8oL9iXpvB3
	7u+wlvZHruGMz6dWfTJf8aYk36rguujtE6Xq+112S7PkO7nnzm4Q++5SL/5uA0PbnTs78rjO
	cqptnvPnTxkLt/35xT83RDv/mhZ5lTGSQVyJpTgj0VCLuag4EQBS+TngFQMAAA==
X-CMS-MailID: 20230517103657epcas5p34671066feb44ca15179e3e3fd25aeba4
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----6TPaBgSVJHTP5aYW_KCyJfD-AyyqAIDIArT8HI0pnVcs47o3=_9bb1a_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230515125841epcas5p3e3cba6545755e95739e1561222b00b4a
References: <cover.1684154817.git.asml.silence@gmail.com>
	<CGME20230515125841epcas5p3e3cba6545755e95739e1561222b00b4a@epcas5p3.samsung.com>
	<5b9f6716006df7e817f18bd555aee2f8f9c8b0c3.1684154817.git.asml.silence@gmail.com>
	<20230516100000.GA26860@green245>
	<65514f94-ac70-08df-a866-fe73f95037fd@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_033707_131323_3250B737 
X-CRM114-Status: GOOD (  20.34  )
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

------6TPaBgSVJHTP5aYW_KCyJfD-AyyqAIDIArT8HI0pnVcs47o3=_9bb1a_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Tue, May 16, 2023 at 07:52:23PM +0100, Pavel Begunkov wrote:
>On 5/16/23 11:00, Kanchan Joshi wrote:
>>On Mon, May 15, 2023 at 01:54:42PM +0100, Pavel Begunkov wrote:
>>>We want to use IOU_F_TWQ_LAZY_WAKE in commands. First, introduce a new
>>>cmd tw helper accepting TWQ flags, and then add
>>>io_uring_cmd_do_in_task_laz() that will pass IOU_F_TWQ_LAZY_WAKE and
>>>imply the "lazy" semantics, i.e. it posts no more than 1 CQE and
>>>delaying execution of this tw should not prevent forward progress.
>>>
>>>Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>>---
>>>include/linux/io_uring.h | 18 ++++++++++++++++--
>>>io_uring/uring_cmd.c     | 16 ++++++++++++----
>>>2 files changed, 28 insertions(+), 6 deletions(-)
>>>
>>>diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
>>>index 7fe31b2cd02f..bb9c666bd584 100644
>>>--- a/include/linux/io_uring.h
>>>+++ b/include/linux/io_uring.h
>>>@@ -46,13 +46,23 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
>>>                  struct iov_iter *iter, void *ioucmd);
>>>void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret, ssize_t res2,
>>>            unsigned issue_flags);
>>>-void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
>>>-            void (*task_work_cb)(struct io_uring_cmd *, unsigned));
>>>struct sock *io_uring_get_socket(struct file *file);
>>>void __io_uring_cancel(bool cancel_all);
>>>void __io_uring_free(struct task_struct *tsk);
>>>void io_uring_unreg_ringfd(void);
>>>const char *io_uring_get_opcode(u8 opcode);
>>>+void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
>>>+                void (*task_work_cb)(struct io_uring_cmd *, unsigned),
>>>+                unsigned flags);
>>>+/* users should follow semantics of IOU_F_TWQ_LAZY_WAKE */
>>
>>Should this also translate to some warn_on anywhere?
>
>Would love to but don't see how. We can only check it doesn't
>produce more than 1 CQE, but that would need
>
>nr_cqes_before = cqes_ready();
>tw_item->run();
>WARN_ON(cqes_ready() >= nr_cqes_before + 1);
>
>but that's just too ugly
>
>
>>>+void io_uring_cmd_do_in_task_lazy(struct io_uring_cmd *ioucmd,
>>>+            void (*task_work_cb)(struct io_uring_cmd *, unsigned));
>>>+
>>>+static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
>>>+            void (*task_work_cb)(struct io_uring_cmd *, unsigned))
>>>+{
>>>+    __io_uring_cmd_do_in_task(ioucmd, task_work_cb, 0);
>>>+}
>>>
>>>static inline void io_uring_files_cancel(void)
>>>{
>>>@@ -85,6 +95,10 @@ static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
>>>            void (*task_work_cb)(struct io_uring_cmd *, unsigned))
>>>{
>>>}
>>>+static inline void io_uring_cmd_do_in_task_lazy(struct io_uring_cmd *ioucmd,
>>>+            void (*task_work_cb)(struct io_uring_cmd *, unsigned))
>>>+{
>>>+}
>>>static inline struct sock *io_uring_get_socket(struct file *file)
>>>{
>>>    return NULL;
>>>diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
>>>index 5e32db48696d..476c7877ce58 100644
>>>--- a/io_uring/uring_cmd.c
>>>+++ b/io_uring/uring_cmd.c
>>>@@ -20,16 +20,24 @@ static void io_uring_cmd_work(struct io_kiocb *req, struct io_tw_state *ts)
>>>    ioucmd->task_work_cb(ioucmd, issue_flags);
>>>}
>>>
>>>-void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
>>>-            void (*task_work_cb)(struct io_uring_cmd *, unsigned))
>>>+void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
>>>+            void (*task_work_cb)(struct io_uring_cmd *, unsigned),
>>>+            unsigned flags)
>>>{
>>>    struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
>>>
>>>    ioucmd->task_work_cb = task_work_cb;
>>>    req->io_task_work.func = io_uring_cmd_work;
>>>-    io_req_task_work_add(req);
>>>+    __io_req_task_work_add(req, flags);
>>>+}
>>>+EXPORT_SYMBOL_GPL(__io_uring_cmd_do_in_task);
>
>--- a/include/linux/io_uring.h
>+++ b/include/linux/io_uring.h
>
>+static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
>+			void (*task_work_cb)(struct io_uring_cmd *, unsigned))
>+{
>+	__io_uring_cmd_do_in_task(ioucmd, task_work_cb, 0);
>+}
>
>That should fail for nvme unless exported.

But it does not. Give it a try.

>>Any reason to export this? No one is using this at the moment.
>>>+void io_uring_cmd_do_in_task_lazy(struct io_uring_cmd *ioucmd,
>>>+            void (*task_work_cb)(struct io_uring_cmd *, unsigned))
>>>+{
>>>+    __io_uring_cmd_do_in_task(ioucmd, task_work_cb, IOU_F_TWQ_LAZY_WAKE);
>>>}
>>>-EXPORT_SYMBOL_GPL(io_uring_cmd_complete_in_task);
>>>+EXPORT_SYMBOL_GPL(io_uring_cmd_do_in_task_lazy);
>>
>>Seems you did not want callers to pass the the new flag (LAZY_WAKE) and
>>therefore this helper.
>
>Yep, I wouldn't mind exposing just *LAZY_WAKE but don't want
>to let it use whatever flags there might be in the future.
>
>Initially I wanted to just make io_uring_cmd_complete_in_task and
>io_uring_cmd_do_in_task_lazy static inline, but that would need
>some code shuffling to make it clean.
>
>>And if you did not want callers to know about this flag (internal
>>details of io_uring), it would be better to have two exported helpers
>>io_uring_cmd_do_in_task_lazy() and io_uring_cmd_complete_in_task().
>>Both will use the internal helper __io_uring_cmd_do_in_task with
>>different flag.
>
>That's how it should be in this patch

Nah, in this patch __io_uring_cmd_do_in_task is exported helper. And
io_uring_cmd_complete_in_task has been changed too (explicit export to
header based one). Seems like bit more shuffling than what is necessary.

------6TPaBgSVJHTP5aYW_KCyJfD-AyyqAIDIArT8HI0pnVcs47o3=_9bb1a_
Content-Type: text/plain; charset="utf-8"


------6TPaBgSVJHTP5aYW_KCyJfD-AyyqAIDIArT8HI0pnVcs47o3=_9bb1a_--

