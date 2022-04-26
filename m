Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A27FC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 05:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RpZntld75c/jtY9am9yxAMrlELWrDR+JIcKnFcJY8zM=; b=cJpjeyjT8bRsNu3yXblpp0E4/V
	0nPaKycREaxewgCUeYi/xwHYR9JPc7YvCXcgGeJ6yQKm1LoCUSp/8YK2DPsrFRbBkpo12IVVrccMk
	8YVVTJpqU0Nfm+lwyMHIgD6Y5OS44rrBDq2pr9cGMZwdoX3BRfKzzSUvB/3NDxpfpXigd6p6XgrbH
	I9N8NIAKhVhkXzn5Kt7BXPjFuCFu/rpsUJQjyLyRTO82OPlaowre3EfDWMO19vN23XXdJBiGdNZnT
	wpzadaMuhuVs9MYIZ5A0SlbiBZfG0NMi6boD1N1RhjPnjRo/IVzuzAPH1JYpw7hhx9TjKNXeCSsAT
	TjLtW21w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njE7N-00CfoS-Bo; Tue, 26 Apr 2022 05:52:09 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njE7G-00CfjC-LO
 for linux-nvme@lists.infradead.org; Tue, 26 Apr 2022 05:52:05 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20220426055156epoutp03b83a49d91acc2ee67b866e9861ffdef5~pXGKDY3Wk2733527335epoutp03D
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 05:51:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20220426055156epoutp03b83a49d91acc2ee67b866e9861ffdef5~pXGKDY3Wk2733527335epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1650952316;
 bh=RpZntld75c/jtY9am9yxAMrlELWrDR+JIcKnFcJY8zM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=QFkTBhzXJoum2RZPji1cShFSExowBieFWKus/9KlFwomdR3miJjkjBnkET4RBCCDA
 LO8MAHXDwVn/FQ5alvNNvQw86x+CaoHulsqBnoyzOjUzW5DSMYeZyjp/yG+xb0TcGa
 iBMpMzWqJirIL8eXk/1untGW0APW9GzXDVy37KZI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20220426055156epcas5p4a7291eb4c5b1f5890e7b72e936e5a9a7~pXGJ14XER1730817308epcas5p4C;
 Tue, 26 Apr 2022 05:51:56 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4KnWGv27Rzz4x9QX; Tue, 26 Apr
 2022 05:51:51 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 5A.B9.09762.47887626; Tue, 26 Apr 2022 14:51:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20220426055108epcas5p4a225ca0c8a8ff31af1f0d63cbc34dd62~pXFdj0Tkg2266022660epcas5p4C;
 Tue, 26 Apr 2022 05:51:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220426055108epsmtrp228e4446b6f5a3d4d166a0e96fe140aa7~pXFdjM0jD1727117271epsmtrp2c;
 Tue, 26 Apr 2022 05:51:08 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-57-62678874b4c7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D7.AC.08853.C4887626; Tue, 26 Apr 2022 14:51:08 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20220426055107epsmtip28c18584918f1e759144158791c18d3d7~pXFcutPxU2828628286epsmtip2-;
 Tue, 26 Apr 2022 05:51:07 +0000 (GMT)
Date: Tue, 26 Apr 2022 11:15:59 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Stefan Roesch <shr@fb.com>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 02/12] io_uring: wire up inline completion path for
 CQE32
Message-ID: <20220426054559.GB14174@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220425182530.2442911-3-shr@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTU7ekIz3JYFMHm8Xqu/1sFu9az7FY
 HOt7z2oxf9lTdourLw+wO7B6TGx+x+5x+Wypx+Yl9R6fN8kFsERl22SkJqakFimk5iXnp2Tm
 pdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAbVVSKEvMKQUKBSQWFyvp29kU5ZeW
 pCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGd0n8oruMZTcab/F0sD406u
 LkZODgkBE4nl7fvZuxi5OIQEdjNKLDp9Fsr5xCix889ORpAqIYFvjBIb1wnCdKx69p0Nomgv
 o8St5w9ZIJxnjBLX11xgB6liEVCVuHn8P3MXIwcHm4CmxIXJpSBhEQE5iVlL97OB2MwCBRJn
 dkwEs4UFgoDmfGQGsXkFdCW2TvnBBGELSpyc+YQFxOYUMJKY+fQJK4gtKqAscWDbcSaQvRIC
 j9glNm74wgRxnYvEovdNbBC2sMSr41vYIWwpic/v9kLFkyVat19mB7lNQqBEYskCdYiwvcTF
 PX+ZIG5Ll7jzdCpUuazE1FProOJ8Er2/n0Ct4pXYMQ/GVpS4N+kpK4QtLvFwxhJWiPEeEgfb
 dSHBsxYYhkcnMk1glJ+F5LVZSNZB2FYSnR+aWGcBtTMLSEss/8cBYWpKrN+lv4CRdRWjZGpB
 cW56arFpgXFeajk8tpPzczcxglOklvcOxkcPPugdYmTiYDzEKMHBrCTCO1U1LUmINyWxsiq1
 KD++qDQntfgQoykwpiYyS4km5wOTdF5JvKGJpYGJmZmZiaWxmaGSOO+p9A2JQgLpiSWp2amp
 BalFMH1MHJxSDUyaZitLzeL1TQ03KVTetjN8ufra9YTVL6RkBa98lbwV0JAzQ0CL911Q6PZw
 /Ru75we2aRycYjXbwOfQPzHTU4dErG1KP5monfrz/956/ui1E6SDbFdzbU2ufvKrJj9M5vLc
 j7s09s+/lPh5ybpf/z9kT8wRmrijuWyRVsM5NouPvGbZ5WWXHnIJ8Ytu1zI9PGlp35Q5rK4T
 TcI0w8+VMlxZkP3Hacsbg7If2kxqFtKJqnHCZ3QMcyevinR2CnoTPEvQJsTx2BKBtsvXq5cJ
 3i8+tLG0UYz37ee3y77s/xH59uy96E0bEji6ysWn5hcnbu13OdH4/WpqMEPiv7U3Nj47+T6k
 Y/95uWs3Pomf+7xAiaU4I9FQi7moOBEA9octlBoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSvK5PR3qSwdr9ehar7/azWbxrPcdi
 cazvPavF/GVP2S2uvjzA7sDqMbH5HbvH5bOlHpuX1Ht83iQXwBLFZZOSmpNZllqkb5fAlbH0
 2S7Ggm6uiin7D7E3MHZwdDFyckgImEisevadrYuRi0NIYDejxMGbu1ggEuISzdd+sEPYwhIr
 /z1nhyh6wihx5MtRsASLgKrEzeP/mbsYOTjYBDQlLkwuBQmLCMhJzFq6nw3EZhYokDizYyKY
 LSwQJHHr+UdmEJtXQFdi65QfTBAz1zJKnL48nQUiIShxcuYTFohmM4l5mx+CzWcWkJZY/g/s
 aE4BI4mZT5+wgtiiAsoSB7YdZ5rAKDgLSfcsJN2zELoXMDKvYpRMLSjOTc8tNiwwzEst1ytO
 zC0uzUvXS87P3cQIDnAtzR2M21d90DvEyMTBeIhRgoNZSYR3qmpakhBvSmJlVWpRfnxRaU5q
 8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1M4Ys+2e18uys57pJcu4fIymqZH0+k
 DKad/GvNfKj+cu9D/WrO7+omQl8UBMoN7Xmvnn7IN+mhXem9ytrLG32jNm0I3qK1/6b6ZeO3
 5oc0sxwnugkx3alxLHqU2VPC1WZ6Oy+pYZbnooioqbeCJb8f4r/7vDldb7dKK/NSMSX5PO/e
 ogMdGlP8jlW+n8E23+pP2Hfn5ukqVdMST5U364aqTGT/uucB98/Y5Jwp9gIayU8nTJ669UlT
 vtYygapmj301m5h6jobbZVx+fivL9n+zQHvGB88kBpst2f63AjuSzk5PYQyfPm33zPvvFjnk
 /v5S37Lc2+e13nrhx9P7F/ycPzetLPmA5kcTjgkab88psRRnJBpqMRcVJwIALR/MGt8CAAA=
X-CMS-MailID: 20220426055108epcas5p4a225ca0c8a8ff31af1f0d63cbc34dd62
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----s9reHD3dvq.Swzu4OgS99nNlXP7CLa0djtt04wdzZepsPVyA=_e037_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220425182556epcas5p48b6bda95efaed3b076508d1e6aba767a
References: <20220425182530.2442911-1-shr@fb.com>
 <CGME20220425182556epcas5p48b6bda95efaed3b076508d1e6aba767a@epcas5p4.samsung.com>
 <20220425182530.2442911-3-shr@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220425_225203_126337_6DE3D901 
X-CRM114-Status: GOOD (  16.11  )
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

------s9reHD3dvq.Swzu4OgS99nNlXP7CLa0djtt04wdzZepsPVyA=_e037_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Mon, Apr 25, 2022 at 11:25:20AM -0700, Stefan Roesch wrote:
>Rather than always use the slower locked path, wire up use of the
>deferred completion path that normal CQEs can take. 
That patch does not do that; patch 5 has what is said here. So bit of
rewording here may clear up the commit message.

>This reuses the
>hash list node for the storage we need to hold the two 64-bit values
>that must be passed back.
>
>Co-developed-by: Jens Axboe <axboe@kernel.dk>
>Signed-off-by: Stefan Roesch <shr@fb.com>
>Signed-off-by: Jens Axboe <axboe@kernel.dk>
>---
> fs/io_uring.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>
>diff --git a/fs/io_uring.c b/fs/io_uring.c
>index 4c32cf987ef3..bf2b02518332 100644
>--- a/fs/io_uring.c
>+++ b/fs/io_uring.c
>@@ -964,7 +964,13 @@ struct io_kiocb {
> 	atomic_t			poll_refs;
> 	struct io_task_work		io_task_work;
> 	/* for polled requests, i.e. IORING_OP_POLL_ADD and async armed poll */
>-	struct hlist_node		hash_node;
>+	union {
>+		struct hlist_node	hash_node;
>+		struct {
>+			u64		extra1;
>+			u64		extra2;
>+		};
>+	};
> 	/* internal polling, see IORING_FEAT_FAST_POLL */
> 	struct async_poll		*apoll;
> 	/* opcode allocated if it needs to store data for async defer */
>-- 
>2.30.2
>
>

------s9reHD3dvq.Swzu4OgS99nNlXP7CLa0djtt04wdzZepsPVyA=_e037_
Content-Type: text/plain; charset="utf-8"


------s9reHD3dvq.Swzu4OgS99nNlXP7CLa0djtt04wdzZepsPVyA=_e037_--

