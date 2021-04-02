Return-Path: <SRS0=ZbIm=I7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA88C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 16:43:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FE3610A0
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 16:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FE3610A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xguEvk+Tmt1EDqTy8/Py1W3/cyI0tEh6WvwCs4/FZKs=; b=lSGW9Igs8MZJHRAbNWooYk84P
	XpfgcMdYzHohaOrUqySHAIBV+F+kmxFUHGKgEkMTJN9dNATnTicoyPB4OhZr9UJGvweS1LESKq37D
	rnNM2w84KINjBPZlzUqDbTxi1pqmRoxFf2AmwxkFG/v2Nckye2DAA3XiJoMHb8nS7p6xFTklAjzye
	WzYa9xIol1nra8Jic8OhDbhv0JHFgx7RKusyrRs8cdSaMh/0eJz6so0tSK6P2FJUIKPoyny/j0QwE
	d9PQyyYpSb78UPEk6Lbsijf6qaOFsH3LQ7t3HnX/+IhxHBXB9HVfUvji2R9njutW7/Ol++ANONf0c
	vzi9fVhSA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lSMtJ-00DPrQ-1J; Fri, 02 Apr 2021 16:43:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lSMtF-00DPqu-Sz
 for linux-nvme@lists.infradead.org; Fri, 02 Apr 2021 16:43:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B1B3C68BEB; Fri,  2 Apr 2021 18:43:18 +0200 (CEST)
Date: Fri, 2 Apr 2021 18:43:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
 "javier@javigon.com" <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: disallow passthru cmd from targeting a nsid
 != nsid of the block dev
Message-ID: <20210402164318.GA21840@lst.de>
References: <20210326194749.396599-1-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210326194749.396599-1-Niklas.Cassel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210402_174322_066096_F131B2E2 
X-CRM114-Status: GOOD (  17.46  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Mar 26, 2021 at 07:48:00PM +0000, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> =

> When a passthru command targets a specific namespace, the ns parameter to
> nvme_user_cmd()/nvme_user_cmd64() is set. However, there is currently no
> validation that the nsid specified in the passthru command targets the
> namespace/nsid represented by the block device that the ioctl was
> performed on.
> =

> Add a check that validates that the nsid in the passthru command matches
> that of the supplied namespace.

git-am doesn't seem to like this patch:

pplying: nvme: disallow passthru cmd from targeting a nsid !=3D nsid of the=
 block
dev
error: invalid mode on line 2: 100644<br>
--- a/drivers/nvme/host/core.c<br>
+++ b/drivers/nvme/host/core.c<br>
@@ -1599,6 +1599,12 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, str=
uct
nvme_ns *ns,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;<br>
=A0 =A0 =A0 =A0 if (cmd.flags)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+=A0 =A0 =A0 =A0if (ns &amp;&amp; cmd.nsid !=3D ns-&gt;head-&gt;ns_id) {<br>
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(ctrl-&gt;device,<br>
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;%s: nsid (%u) in cmd =
does not match nsid (%u) of
namespace\n&quot;,<br>
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0current-&gt;comm, cmd.nsid,=
 ns-&gt;head-&gt;ns_id);<br>
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;<br>
+=A0 =A0 =A0 =A0}<br>
<br>
=A0 =A0 =A0 =A0 memset(&amp;c, 0, sizeof(c));<br>
=A0 =A0 =A0 =A0 c.common.opcode =3D cmd.opcode;<br>
@@ -1643,6 +1649,12 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl,
struct nvme_ns *ns,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;<br>
=A0 =A0 =A0 =A0 if (cmd.flags)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+=A0 =A0 =A0 =A0if (ns &amp;&amp; cmd.nsid !=3D ns-&gt;head-&gt;ns_id) {<br>
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(ctrl-&gt;device,<br>
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;%s: nsid (%u) in cmd =
does not match nsid (%u) of
namespace\n&quot;,<br>
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0current-&gt;comm, cmd.nsid,=
 ns-&gt;head-&gt;ns_id);<br>
+=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;<br>
+=A0 =A0 =A0 =A0}<br>
<br>
=A0 =A0 =A0 =A0 memset(&amp;c, 0, sizeof(c));<br>
=A0 =A0 =A0 =A0 c.common.opcode =3D cmd.opcode;<br></blockquote></div></div=
><div
dir=3D"auto"><br style=3D"font-family:sans-serif;font-size:12.8px"><span
style=3D"font-family:sans-serif;font-size:12.8px">Looks good.</span></div><=
div
dir=3D"auto"><span style=3D"font-family:sans-serif;font-size:12.8px">Review=
ed-by:
Kanchan Joshi &lt;joshi.k</span><a href=3D"mailto:javier@javigon.com"
style=3D"text-decoration-line:none;color:rgb(66,133,244);font-family:sans-s=
erif;font-size:12.8px">@samsung.com</a><span
style=3D"font-family:sans-serif;font-size:12.8px">&gt;</span><br></div><div
dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockq=
uote
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc
solid;padding-left:1ex"></blockquote></div></div></div>




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
