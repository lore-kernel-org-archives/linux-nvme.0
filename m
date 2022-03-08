Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C604C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 15:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B9TCCvMpq0hZ8/Gfc3DGPxKEOS7j8oXEpRjRFqsjyFU=; b=PAr2PiDuMwj+V5D+fJI2MLgrAj
	kP3w7hGgaho4rTFz2BPjJabDzpYy9XhywENt1vdHjQM5zGcFKFGnIHuQ8/BcD3tOXV8Jls3f+Z3vi
	73k9DRag9lzwR1+cHoNT04f9HKPvlEJLTtNGaq3h2TNy+Fjr9nPuZvAYpf+8QQlSd4Bhe2aFFZlAZ
	QDd5yYoApy4YUuZRC94J27wwLKCUylmhi4/bdpplJ9jfJxiTf7+xVG2hDFesHrik1ALFLvIQShO44
	7XhdaiHSLmy0w9rEQwhP+hIQMuVNjAz8BOgwBHs/IU6Yu0q/oTycxK8QhMx1ieLSR4DqflWQe4+bh
	SkThMvFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRc3c-0052Wa-DE; Tue, 08 Mar 2022 15:47:28 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRbz2-0050oM-2E
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 15:42:47 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20220308154242epoutp03f77e6891f5f0e4304d2e56d69727e756~aci_BT8uD2772027720epoutp03d
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 15:42:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20220308154242epoutp03f77e6891f5f0e4304d2e56d69727e756~aci_BT8uD2772027720epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1646754162;
 bh=B9TCCvMpq0hZ8/Gfc3DGPxKEOS7j8oXEpRjRFqsjyFU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=a1qbUeCVC85O/d9o9pjyBjUdN0oxRnKCImsmwGVM0lP6UoXwT5ojM6tDfL2/fpjAW
 zqMmY8GwNNc1VyCl2f6gWZXBlIEN6kWSMeIjYCPpcXEKQowoNP2G3AfFJkpdmYNVgj
 X/yqmWCPiZxkaPf7Zg8T2GeVISUdlINdJqb8MC9w=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20220308154241epcas5p45d1f0d628e028943aa92360091e60bb3~aci9ZQ1-H0458304583epcas5p4J;
 Tue,  8 Mar 2022 15:42:41 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4KCfjB3kgFz4x9Pp; Tue,  8 Mar
 2022 15:42:38 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 7A.57.06423.E6977226; Wed,  9 Mar 2022 00:42:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20220308152711epcas5p31de5d63f5de91fae94e61e5c857c0f13~acVbjD1AI0623006230epcas5p3d;
 Tue,  8 Mar 2022 15:27:11 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220308152711epsmtrp2182fc0fe1c80190c69467d6c864a0e91~acVbiFBOx2761027610epsmtrp2D;
 Tue,  8 Mar 2022 15:27:11 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-00-6227796ea243
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 38.96.03370.FC577226; Wed,  9 Mar 2022 00:27:11 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220308152709epsmtip1d1199c377ac2493630a28bda0b92732b~acVZhcOPT0990109901epsmtip1c;
 Tue,  8 Mar 2022 15:27:09 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com, logang@deltatee.com,
 pankydev8@gmail.com, javier@javigon.com, mcgrof@kernel.org,
 a.manzanares@samsung.com, joshiiitr@gmail.com, anuj20.g@samsung.com
Subject: [PATCH 09/17] io_uring: plug for async bypass
Date: Tue,  8 Mar 2022 20:50:57 +0530
Message-Id: <20220308152105.309618-10-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308152105.309618-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmum5epXqSQdc+CYvphxUtmib8ZbaY
 s2obo8Xqu/1sFitXH2WyeNd6jsWi8/QFJovzbw8zWUw6dI3RYu8tbYv5y56yWyxpPc5mcWPC
 U0aLNTefslh8PjOP1YHf49nVZ4weO2fdZfdoXnCHxePy2VKPTas62Tw2L6n32H2zgc1j2+KX
 rB59W1YxenzeJBfAFZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr
 5OIToOuWmQP0g5JCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10v
 L7XEytDAwMgUqDAhO+PJjqtsBUdZKq5/3cPYwLifuYuRk0NCwETi476V7F2MXBxCArsZJXo2
 LmCBcD4xSvTPWsMK4XxmlPj78hlcy9LN85ggErsYJT5fWc0GV3XhzEmgDAcHm4CmxIXJpSAN
 IgJeEvdvvwebxCzQxSTxdt99NpCEsICZxNtff1lBbBYBVYmDZ+aA9fIKWEl8XWsPsUxeYual
 7+wgNidQ+OetrWDlvAKCEidnPmEBsZmBapq3zmYGmS8hcIRDomXHDUaIZheJQ78vs0PYwhKv
 jm+BsqUkPr/bywZhF0v8unMUqrmDUeJ6w0wWiIS9xMU9f8EOYgZ6Zv0ufYiwrMTUU+uYIBbz
 SfT+fsIEEeeV2DEPxlaUuDfpKSuELS7xcMYSKNtD4vT3pdCQ62WU6Hp4l30Co8IsJA/NQvLQ
 LITVCxiZVzFKphYU56anFpsWGOallsOjOTk/dxMjOGFree5gvPvgg94hRiYOxkOMEhzMSiK8
 98+rJAnxpiRWVqUW5ccXleakFh9iNAUG+ERmKdHkfGDOyCuJNzSxNDAxMzMzsTQ2M1QS5z2d
 viFRSCA9sSQ1OzW1ILUIpo+Jg1OqgUmRc+OcgtIV99bO/mMY2WFR9vXCI8dZ/Ifcq9z9Hndt
 qflxfWLV/KeHZlhPW7XmUZ5lfMJ07RiBORnH5BfvWLfqxZOtisK1fqyyCocKDGub0nvlZL4+
 VFwVeDSBM70naWZEpw2Po6Pzzx29anvlwiYV2NivWG7Geq0v9o13jRI33/QDjw/s7t0Y8Gt5
 SFPOpHk512tk+Q+GHjIwu+SV4WWnxCH8WSVKnaHDavM8+f5vhyo4Tr//92DhnvTfXy9tPXau
 esqWfev6TkrnyXo1FLo8Fl3Devh9izBPpOacSQ9nda8StNsrcPrYkmofrY0OIV5yLXdXpfgy
 Cgr/cTh+/vS7WUmiP/mz05u+dK9b+1eJpTgj0VCLuag4EQA2GwXSYQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJTvd8qXqSwf7fahbTDytaNE34y2wx
 Z9U2RovVd/vZLFauPspk8a71HItF5+kLTBbn3x5msph06Bqjxd5b2hbzlz1lt1jSepzN4saE
 p4wWa24+ZbH4fGYeqwO/x7Orzxg9ds66y+7RvOAOi8fls6Uem1Z1snlsXlLvsftmA5vHtsUv
 WT36tqxi9Pi8SS6AK4rLJiU1J7MstUjfLoEr48mOq2wFR1kqrn/dw9jAuJ+5i5GTQ0LARGLp
 5nlMXYxcHEICOxglFkx5zQKREJdovvaDHcIWllj57zk7RNFHRomru/8CORwcbAKaEhcml4LU
 iAgESBxsvAxWwywwg0mip/kz2CBhATOJt7/+soLYLAKqEgfPzGEC6eUVsJL4utYeYr68xMxL
 38F2cQKFf97aClYuJGApsWLdbzYQm1dAUOLkzCdgI5mB6pu3zmaewCgwC0lqFpLUAkamVYyS
 qQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwfGkpbWDcc+qD3qHGJk4GA8xSnAwK4nw3j+v
 kiTEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QDk7qPS4C/
 0SOHp4nyAplJGmGzJ8y5dViTReLq2tZYOc6bW/gm+dRy9+aeX/BzjtnEt+0aFSXCS9kPcYWL
 XdHKmfF4UgUr199Hk2QO1XPtWLqId/qBmwqbdSbIlrKEdebX3lTzDzz7J+u6wQKptF9n4zPT
 NP93qT7ulIxmTXvEwfTjzvOoPRNUdhSeu7ypYrLdjKNi2W+2ZH3Ywp4qIi714sNRJp2WJq1D
 7fwndtx4lvM+2nqCg3N0eO8l5rjlUs5psi5F0TcS5ll/SfKZM/lywDK3vS5TK4V3Pdy7KO2l
 5/EvVlor5uT96jltWjy7VXumma5ESOjtC4Im30QvLDkYemD6CvFT6i06jx7Xfd8spcRSnJFo
 qMVcVJwIAHVdqpsWAwAA
X-CMS-MailID: 20220308152711epcas5p31de5d63f5de91fae94e61e5c857c0f13
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220308152711epcas5p31de5d63f5de91fae94e61e5c857c0f13
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152711epcas5p31de5d63f5de91fae94e61e5c857c0f13@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_074244_519152_F4F27841 
X-CRM114-Status: GOOD (  13.70  )
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

From: Jens Axboe <axboe@kernel.dk>

Enable .plug for uring-cmd.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6a1dcea0f538..f04bb497bd88 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1106,9 +1106,11 @@ static const struct io_op_def io_op_defs[] = {
 	[IORING_OP_LINKAT] = {},
 	[IORING_OP_URING_CMD] = {
 		.needs_file		= 1,
+		.plug			= 1,
 	},
 	[IORING_OP_URING_CMD_FIXED] = {
 		.needs_file		= 1,
+		.plug			= 1,
 	},
 };
 
-- 
2.25.1


