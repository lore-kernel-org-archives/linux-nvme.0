Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93988C32772
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Aug 2022 12:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hdi5MwCqE5byIowYTj8N8wyEJGu5qQo7Ux+azd3wEpQ=; b=zstBGgRV/3aHk2USl6UzntI/22
	cZWVoBIB3mpWjstbjn1L0FEzARRJNdQA48TBhU0AtmyC/f+LsAQBGM5jzoXDC5QFDI3WVqaUlcrs4
	eyt1k6E7ogxUkDM4v2dpw6hYcgAAAxliTmXg/hz6twV99FknrpL5bcGTcnzCeA0NSOYEFsnCBf048
	MZPB26R5L3+N4dWEfteq3nxjBtbyCijtGIzYHNRuv5WuLqOvox7PnjJYm1hy7FoFQ2MikgTMQAnPf
	SFqDECLNH2osdBm1Fjo1C96EwZlkkxbztDQVZbwsg+Fy3o6qwuCGpHTMvdo2YI3tgdMeyTcrboR+R
	4fey4bnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQT1Z-005s73-V7; Tue, 23 Aug 2022 12:28:54 +0000
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQSwh-005pbd-67
	for linux-nvme@lists.infradead.org; Tue, 23 Aug 2022 12:23:52 +0000
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so16521551fac.12
        for <linux-nvme@lists.infradead.org>; Tue, 23 Aug 2022 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=hdi5MwCqE5byIowYTj8N8wyEJGu5qQo7Ux+azd3wEpQ=;
        b=TT4Ut5NG8wDa+UMh/lNtQc1q0LcRDM267Nhj0AVUCb8MbgGlGThl+yfzCGUR8HfEDN
         HlwvrgnhiFRCk1I5zkPWnQlsVMfp2NnqdvK0tLZBFthgTuTRo7zdyHfGzPXENoGlnDEb
         r9IDMnAkHlbf8nDoZChmONmz89m70VTMen/VRuaB7XeJ/9tZAJJqkaL1EylYKbnyY/VU
         uFlQklzNXsfONEcj/mIdwG7sd4dBps5aT/lj0P+nT7S6eM6NvPkdWU97WJ1KLk2D/38U
         8tHciUtCmu9T2gkEEBtDNggfrMF2D0bwY/aT2P50fCWPSE2b5FShLI6+4NlS1GM4+pwF
         Baqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=hdi5MwCqE5byIowYTj8N8wyEJGu5qQo7Ux+azd3wEpQ=;
        b=JYrTY31l55i0OTgZHPbIjFkF2zPGTthf/2BVXuye0Mas+hFRL74rIBlAfLTy8CxbTv
         0W+XTPjXljAbF20krpsr5ecalhWCd5cIIO2nlltZnyOIkOaqUTRIVmD9JAt9xoOunRR2
         3CpLkBK4sG8gCUxnrvXjqyN+/kM/r10iJY6E0dt1n7ZZgBrDDY11lPMLXr589RaiGUpF
         T4zwdgc1McJp2jH+JJWu8kBWCLZkBI/6F5CwoX8AS2YxbtBsV/q3kWjK3QjXKAOWy67Z
         cOfzLaT7lK1sCQeXg3QRU3TKA4vDLcDvNCebxiKT8OcPRrnljtEdYhEbquiRblyMgfnl
         iN4A==
X-Gm-Message-State: ACgBeo0VnQtjdc5L44CXcDKlAyHmWcybfjtltLDmfqfkHFbA8jFqsbuh
	By5AfO1i6iiVdzxVZ1jx7SomMi9XUrls1KXuUQ==
X-Google-Smtp-Source: AA6agR4Hk+qtrYOq67QDe8RsoCMdRS3hkerYea17fieVkENuE0eMKn33HrNSgduI6GdfT9ZXhVdUCmrxWt6Iji1XOEA=
X-Received: by 2002:a05:6870:b28d:b0:10e:6805:b9c1 with SMTP id
 c13-20020a056870b28d00b0010e6805b9c1mr1265558oao.37.1661257428144; Tue, 23
 Aug 2022 05:23:48 -0700 (PDT)
MIME-Version: 1.0
From: Tal Lossos <tallossos@gmail.com>
Date: Tue, 23 Aug 2022 15:23:37 +0300
Message-ID: <CAO15rPn8MBD5+QX31xjFsccT_1bRSuYYm2P1cTWqTydZTkiH+g@mail.gmail.com>
Subject: [bug report] nvme: NULL pointer dereference in nvmet_setup_auth
To: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220823_052351_284909_82A74F2C 
X-CRM114-Status: UNSURE (   5.98  )
X-CRM114-Notice: Please train this message.
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

Hello,
There is a NULL pointer dereference in nvmet_setup_auth() introduced
in commit db1312dd95488b5e6ff362ff66fcf953a46b1821 causing a DoS.
As of v6.0-rc2, in target/auth.c:196, if there is an error with
ctrl->ctrl_key, it gets reassigned to NULL, and one line afterwards,
it gets dereferenced in the call for pr_debug():

ctrl->ctrl_key = nvme_auth_extract_key(host->dhchap_ctrl_secret + 10,
    host->dhchap_ctrl_key_hash);
if (IS_ERR(ctrl->ctrl_key)) {
    ret = PTR_ERR(ctrl->ctrl_key);
    ctrl->ctrl_key = NULL;   <--- Assigning NULL
}
pr_debug("%s: using ctrl hash %s key %*ph\n", __func__,
ctrl->ctrl_key->hash > 0 ?   <--- NULL pointer dereference
nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none",
(int)ctrl->ctrl_key->len, ctrl->ctrl_key->key);

This bug occurs probably due to a missing goto statement (goto out_unlock).

Best Regards,
Tal Lossos

