Return-Path: <SRS0=NYF9=3C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837F1C33CA9
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2020 19:14:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A9F21556
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2020 19:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JPMulNcx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5Cqf28s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A9F21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3KJ+G+Bd1MQSZKSEmKY5RIk2FDf0iDgTeiOvtLIKBhI=; b=JPMulNcxgURGEI
	s7KbVopJlAsMl04x5bTstBdcMK3/DNh4uw98Kl9Fw7Nfff6GI8n878ojOjGzTvP4WJj023BOjz0C2
	IZnocM6B1Z1h+uovNqoAvEXzjRijp2+E3uGeAyyAh1T6QX2Z2K872pCYvJhkLt3sXL8Nc+W3bA0lv
	wFo0oxQFK1YutmTYYmNxvFuDv747w577fGQA/n3cgxUT18I4+khV4uHhji0khmrvwtAq+3g007D9E
	yJA3y+h/ShJrKUNEEE+8DKW94j8Td5puzvWBNztTdhbacE6wEYWoiRrSVUmwCsqu35NJvGLn6zaaU
	mJvXXBm+gmiaHSiOReug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ir5AT-0007Oi-4J; Mon, 13 Jan 2020 19:14:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ir5AP-0007OM-4h
 for linux-nvme@lists.infradead.org; Mon, 13 Jan 2020 19:14:26 +0000
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CFB7C222C4
 for <linux-nvme@lists.infradead.org>; Mon, 13 Jan 2020 19:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578942864;
 bh=LgMw0iYVlmL769HXp3a4BUloYXbNQ+gIZJ3aeOv5krg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=b5Cqf28sxlcU8f9fyL0hu/Dur0H7Vl2M2T8jQEpg5wPErYr6q0pY+pm4Lg3+NnvZw
 //VWwKwhxROzTmHier5nPTub8KKGbaD0BceDehodHZsaYyubJkJjnpuzkbZW6DSfIM
 XQXKDp0lhSnl0KPgvaHiFbNb4+uU1y4JcxaDU3Gk=
Received: by mail-wr1-f53.google.com with SMTP id j42so9759168wrj.12
 for <linux-nvme@lists.infradead.org>; Mon, 13 Jan 2020 11:14:23 -0800 (PST)
X-Gm-Message-State: APjAAAXBTz8xnZi3Ge6WltdxIglO4oW/g9Pcgda6Unh49306y1qm/ftC
 sRJW2pFelNg4v9wOS+zpa1pxbcsfN1Or6wPRrcv5sQ==
X-Google-Smtp-Source: APXvYqz22ZlgTNdJaV+ygCWB8LAYLXz0ORyxWwgQ0kEz9BgnW77HFEpBTS8mJ84sXXCAahM/APNBvWq7Q94+ppJs8Ik=
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr19949499wrp.111.1578942862294; 
 Mon, 13 Jan 2020 11:14:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576726427.git.luto@kernel.org>
 <b4feb87b30edfb30998a2b42de3b1e0618203700.1576726427.git.luto@kernel.org>
 <7ae79adc-896c-f007-dcf8-3cff84b3bc02@redhat.com>
In-Reply-To: <7ae79adc-896c-f007-dcf8-3cff84b3bc02@redhat.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 13 Jan 2020 11:14:10 -0800
X-Gmail-Original-Message-ID: <CALCETrXOu85fPfaMtUNsLOSOmue41Lyk413mKwHHD9w8AokZ9A@mail.gmail.com>
Message-ID: <CALCETrXOu85fPfaMtUNsLOSOmue41Lyk413mKwHHD9w8AokZ9A@mail.gmail.com>
Subject: Re: [PATCH 3/4] Use systemd-generated hostid if no hostid is
 configured
To: David Milburn <dmilburn@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200113_111425_204616_89627FE2 
X-CRM114-Status: GOOD (  18.50  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme <linux-nvme@lists.infradead.org>,
 Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jan 3, 2020 at 10:14 AM David Milburn <dmilburn@redhat.com> wrote:
>
> Hello Andy,
>
> On 12/19/2019 09:31 PM, Andy Lutomirski wrote:
> > This is just like the hostnqn support.  It adds a show-hostid command
> > for introspection.
> >
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > ---
> >   Documentation/nvme-show-hostid.txt | 29 +++++++++++++++
> >   fabrics.c                          | 57 ++++++++++++++++++++++++++----
> >   fabrics.h                          |  1 +
> >   nvme-builtin.h                     |  1 +
> >   nvme.c                             | 15 ++++++++
> >   5 files changed, 96 insertions(+), 7 deletions(-)
> >   create mode 100644 Documentation/nvme-show-hostid.txt
> >
> > diff --git a/Documentation/nvme-show-hostid.txt b/Documentation/nvme-show-hostid.txt
> > new file mode 100644
> > index 000000000000..52bdc8a1f480
> > --- /dev/null
> > +++ b/Documentation/nvme-show-hostid.txt
> > @@ -0,0 +1,29 @@
> > +nvme-show-hostid(1)
> > +===================
> > +
> > +NAME
> > +----
> > +nvme-show-hostid - Generate a host NVMe ID
> > +
>
> I pulled the latest nvme-cli and applied your patch set
>
> https://github.com/linux-nvme/nvme-cli
>
> Seems to work on Fedora 31
>
> $ nvme show-hostnqn
> nqn.2019-10.us.luto:sd_id128_app:a9e4b2c8953340988142e32ca6d67922
>
> $ nvme show-hostid
> f467779d-1940-4659-b200-74278899b2ca
>

Good news!  When I run it, I get different output!

$ ./nvme show-hostnqn
nqn.2019-10.us.luto:sd_id128_app:a3cee2b99e504da68d4b9e7de354bebd
$ ./nvme show-hostid
c701865f-88c9-43c3-83a0-ead417dea2de

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
