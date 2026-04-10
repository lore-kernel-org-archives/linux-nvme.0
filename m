Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3676E99071
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2026 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2vrsmRap/kjG+mEClgsR5dKngCPQVgSMV7MzsfrvrtA=; b=4TdHCy1/pji1p3WG6EGIUAATiP
	0ZY8XSEiBPVdjWRTGGqWDrYOvrwnyLyINZ2e7RZBeS5xc4zxCNI8eOhF5OxriTgSOcdUEKR9gIfP1
	bnhK6jR8+HY3S41GHPahtFpf0i9GZYp+GiJgw9LxTWT+TnwS9FvTSzlGyj0qV62BZnypF4/mXtIOg
	+Wnb5T9jxgoY1stwY29GbI9wHhSw5I9AmYQywQhYpiElp6jI8T46BtBAoG18qGTKGHLXTG7hP/2Ls
	b/HgwSf4MYnVh5AkO/Ze12dUqJAGmWw7Ar6Gxi1pNjhYQRjEwlEAbAM5LHmGc9RJBDdXam1WnsY/E
	/COThtTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB8sC-0000000BzBQ-2PJo;
	Fri, 10 Apr 2026 10:14:00 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB8s9-0000000BzAB-2LHI
	for linux-nvme@lists.infradead.org;
	Fri, 10 Apr 2026 10:13:58 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-483487335c2so20305205e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 10 Apr 2026 03:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775816036; x=1776420836; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2vrsmRap/kjG+mEClgsR5dKngCPQVgSMV7MzsfrvrtA=;
        b=T4jNlbZ9Zcy8pZPkwBv/eK7Eat+Ok0/KONdN0kcGNJHpvW/FjxCHO5vzERqVjMCq9d
         6YE77VDp8f44Z8taWSBe9Vk/P9P8LAtqQB6S0MT1O8+I2UY6cts9LDrG80jKJ9UU6dLV
         HAcgOFkLLaveJL75XHKkAlitjmJij9kxwsJ/OzK5HLaz6mZJkxFXHZtZ3wkzTxfBUSjk
         CCFtx7Zt843MGkVjw/+wLlpTY6Q+le8Rac7q7/4Xoym4kzW2MHYjTNti9EQMTqz2G8yu
         H3wYhOtLtoVygTAydj+fyIfnWn9vdduF/61Ce3eVAcAVZYkdrG/PWfkjbMmj+7e6O69r
         cLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775816036; x=1776420836;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vrsmRap/kjG+mEClgsR5dKngCPQVgSMV7MzsfrvrtA=;
        b=i1IAgzqPWmy3V7XUnt5uJgcwx9n+fSAvaIN+AKRdkpQtCBGZ/wArkR2Fh6QAaF+ANu
         wn2NxQLCwAVtv+rPHxqIEbWjJVuVyhUd91uB1QxvpW8PpIw+fROalhMoS5MugmA68lZp
         Ovsj0Rd9zySENaSPNy7WyJS+ervmvxUk3IXg9nONPBsl9GTUyqeTCbJdmvB/o353rfxD
         7FTb1Z3e6vF4+knwfH+zaMjj9MtHRPt7i3fGGrUOScE4MUpxzLjBhNVwHd9hmqKjEy4o
         0ElWt8RNN7u4uaHpj5/TjvMabFFgMnEHb+UzUrhv7ZzZubAnVITJBY2OEk8v94xvp06c
         uqBg==
X-Gm-Message-State: AOJu0YzEyAasVqqKtQ6Xpg1I1mIyoXbFLGioqEkbF8E19Ucnqk9skuxP
	P72h/E4nhPlmQbn7XTBwX4CubJ3B7CA523RHnVO2Cpn+XduG2u9mQP+Ou0RK/kxu
X-Gm-Gg: AeBDievd7kuhp2OellSsubkciAC8SgJI+6gM3uV/BMVgXlPykI/9mV2ZUn/9TjiDbiS
	HKGV03sZUrQVAKBVAGAcsqnWbNo1tMJd8ydmrC/YOIJPJLC4wgB8PIr89O4hppZ3lpc0eqpgmcU
	yLtySufJNmsA8QJQAwEHAmXfjsqaQvjceG1ohc4PlvYRUADcADkQEbDsja3SBRYqGU4xljs4Hz2
	gtFNUpF6mHUEoBfw8ws/Z1f1bj0N986dODUruHoqaVBFgz/lC2ixaMTRLdQHzxEKI0ywlYpfmmL
	E1YSpf1GtMPPBBrDEEdURotqBTUYQEuby4gxdplwgqkFb++8OTTMLaDjH8MKN7clfZrkZuCKSNy
	kRYqKt3hR2pRb5f7SUgXps66bXklAU0/m/WOpgVt79CJAOatQ1eaNtOiHn8g4HRyUrr83ns8RSd
	wkH5I+ppxAtR+MVWYN56I=
X-Received: by 2002:a05:600c:c0c8:b0:488:af14:f1de with SMTP id 5b1f17b1804b1-488d67b8de8mr22371295e9.4.1775816035557;
        Fri, 10 Apr 2026 03:13:55 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67a46bdsm26414045e9.3.2026.04.10.03.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:13:55 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:13:52 +0300
From: Dan Carpenter <error27@gmail.com>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org
Subject: [bug report] nvme: add support for dynamic quirk configuration via
 module parameter
Message-ID: <adjNYMeHY3hz9Eb3@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_031357_619755_E40768B6 
X-CRM114-Status: UNSURE (   8.06  )
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

Hello Maurizio Lombardi,

Commit 7bb8c40f5ad8 ("nvme: add support for dynamic quirk
configuration via module parameter") from Feb 4, 2026 (linux-next),
leads to the following Smatch static checker warning:

	drivers/nvme/host/pci.c:216 quirks_param_set()
	warn: missing error code here? 'nvme_parse_quirk_entry()' failed. 'err' = '0'

drivers/nvme/host/pci.c
    181 static int quirks_param_set(const char *value, const struct kernel_param *kp)
    182 {
    183         int count, err, i;
    184         struct quirk_entry *qlist;
    185         char *field, *val, *sep_ptr;
    186 
    187         err = param_set_copystring(value, kp);
    188         if (err)
    189                 return err;
    190 
    191         val = kstrdup(value, GFP_KERNEL);
    192         if (!val)
    193                 return -ENOMEM;
    194 
    195         if (!*val)
    196                 goto out_free_val;
    197 
    198         count = 1;
    199         for (i = 0; val[i]; i++) {
    200                 if (val[i] == '-')
    201                         count++;
    202         }
    203 
    204         qlist = kcalloc(count, sizeof(*qlist), GFP_KERNEL);
    205         if (!qlist) {
    206                 err = -ENOMEM;
    207                 goto out_free_val;
    208         }
    209 
    210         i = 0;
    211         sep_ptr = val;
    212         while ((field = strsep(&sep_ptr, "-"))) {
    213                 if (nvme_parse_quirk_entry(field, &qlist[i])) {
    214                         pr_err("nvme: failed to parse quirk string %s\n",
    215                                 value);
--> 216                         goto out_free_qlist;

Propagate the error code from nvme_parse_quirk_entry()?

    217                 }
    218 
    219                 i++;
    220         }
    221 
    222         kfree(nvme_pci_quirk_list);
    223         nvme_pci_quirk_count = count;
    224         nvme_pci_quirk_list  = qlist;
    225         goto out_free_val;
    226 
    227 out_free_qlist:
    228         kfree(qlist);
    229 out_free_val:
    230         kfree(val);
    231         return err;
    232 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

