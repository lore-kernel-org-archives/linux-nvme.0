Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE83F44842
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2026 11:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wqe3a1Am7UNDr2zDqh72zvAFUksMPKol14IFt1IPyyo=; b=Pn96jqAQlQBUoe8ZXisIYmd7GV
	wdB3fzSxoFDP3krhuTBsT0M+p6nhiASTQ4rLhq09kXGP+eVYkcWpGDVK/UMINlTTGzPC2V+Oq+98S
	9yQh2sn24soCyyCklPuKe41Ws3OYJSt0kVYWs13xW0e+g1DG672wJECoYAkYmLKFcGGUihYbR6NI1
	inDCPlCwxGq39U6IJw1AcWjrPjpzPlU52JC/VHZkOpT/8QgjGohMnSKjORLMFITaBLRRkOTsrsWJn
	YrAwImN2s46GJcaIaGh74ytysL8wtXHO+lqjrEEEU2TtkjJ1tqpxoFAGkzilfSIfukLw7y3q7lzmU
	ZFBzMbzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBA2s-0000000C5Cl-1VES;
	Fri, 10 Apr 2026 11:29:06 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBA2o-0000000C5CC-2cEG
	for linux-nvme@lists.infradead.org;
	Fri, 10 Apr 2026 11:29:04 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id ea6326a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 13:28:56 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Apr 2026 13:28:55 +0200
Message-Id: <DHPFUBP3MZHA.3U9OCBKEW0UXV@arkamax.eu>
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Dan Carpenter" <error27@gmail.com>, "Maurizio Lombardi"
 <mlombard@redhat.com>
Cc: <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] nvme: add support for dynamic quirk configuration
 via module parameter
X-Mailer: aerc 0.21.0
References: <adjNYMeHY3hz9Eb3@stanley.mountain>
In-Reply-To: <adjNYMeHY3hz9Eb3@stanley.mountain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_042903_027898_B0FCD964 
X-CRM114-Status: GOOD (  11.59  )
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

Hello Dan,

On Fri Apr 10, 2026 at 12:13 PM CEST, Dan Carpenter wrote:
> Hello Maurizio Lombardi,
>
> Commit 7bb8c40f5ad8 ("nvme: add support for dynamic quirk
> configuration via module parameter") from Feb 4, 2026 (linux-next),
> leads to the following Smatch static checker warning:
>
> 	drivers/nvme/host/pci.c:216 quirks_param_set()
> 	warn: missing error code here? 'nvme_parse_quirk_entry()' failed. 'err' =
=3D '0'

Thanks for reporting this.

I didn't want to propagate the error code here, preventing the nvme-pci
kernel module from loading (and potentially making the machine
unbootable) just because the user misspelled a quirk's name.

In my opinion an error message in dmesg is sufficient, therefore I will
not fix this unless the maintainers have a different opinion.

Thanks,
Maurizio

>
> drivers/nvme/host/pci.c
>     181 static int quirks_param_set(const char *value, const struct kerne=
l_param *kp)
>     182 {
>     183         int count, err, i;
>     184         struct quirk_entry *qlist;
>     185         char *field, *val, *sep_ptr;
>     186=20
>     187         err =3D param_set_copystring(value, kp);
>     188         if (err)
>     189                 return err;
>     190=20
>     191         val =3D kstrdup(value, GFP_KERNEL);
>     192         if (!val)
>     193                 return -ENOMEM;
>     194=20
>     195         if (!*val)
>     196                 goto out_free_val;
>     197=20
>     198         count =3D 1;
>     199         for (i =3D 0; val[i]; i++) {
>     200                 if (val[i] =3D=3D '-')
>     201                         count++;
>     202         }
>     203=20
>     204         qlist =3D kcalloc(count, sizeof(*qlist), GFP_KERNEL);
>     205         if (!qlist) {
>     206                 err =3D -ENOMEM;
>     207                 goto out_free_val;
>     208         }
>     209=20
>     210         i =3D 0;
>     211         sep_ptr =3D val;
>     212         while ((field =3D strsep(&sep_ptr, "-"))) {
>     213                 if (nvme_parse_quirk_entry(field, &qlist[i])) {
>     214                         pr_err("nvme: failed to parse quirk strin=
g %s\n",
>     215                                 value);
> --> 216                         goto out_free_qlist;
>
> Propagate the error code from nvme_parse_quirk_entry()?
>
>     217                 }
>     218=20
>     219                 i++;
>     220         }
>     221=20
>     222         kfree(nvme_pci_quirk_list);
>     223         nvme_pci_quirk_count =3D count;
>     224         nvme_pci_quirk_list  =3D qlist;
>     225         goto out_free_val;
>     226=20
>     227 out_free_qlist:
>     228         kfree(qlist);
>     229 out_free_val:
>     230         kfree(val);
>     231         return err;
>     232 }
>
> This email is a free service from the Smatch-CI project [smatch.sf.net].
>
> regards,
> dan carpenter


