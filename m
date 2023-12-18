Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41ACC35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 15:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=evLAdIe0JUCK69vN8gt9neF+11vcKJB0GVTlnE+cvjA=; b=fstdHKeoSVbAJsIlks6AvZKfkd
	T6k+F3hkRCEnuea2jrbJ6JZcYZAEW7NSz7Rd1g92ikoeHGpDzv9piKfGNy6RFDG0qUoO8jesNZ6Ux
	VKzN58NgMIM/ZjqmW70RHDk4gplUqbLyO5AHZs2pXtQGbd6tp1e9sX35aTfqDg6g6sJJK+2cvSWWs
	/veQRwzVxhDrHbOyv3krNUAzBk6VmMwOlzxDSPb4TwGdUUifLOji3RR1Y8Ln04LyKhmRuhrEuK9Ru
	pWHROvSY1cFJCb+O9QjJahxCEXzls1Pv1BNxiHcTy4IQWDcc00NJ6My3FNYSPoWozvtjORHsR6gyg
	gGZrg7+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFHq-00B9rf-0n;
	Mon, 18 Dec 2023 15:12:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFHm-00B9qp-35
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 15:12:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702912318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evLAdIe0JUCK69vN8gt9neF+11vcKJB0GVTlnE+cvjA=;
	b=W6WMH+HWkq25y5rMBD19vP1NEHBOEow/i4lc/QFZoh7T6cOvQHM61y+QJlh8KbU+BgASRH
	k0I4vd7pooh2nI8sGloCJg6PHuTougUQ4EGKVonqrzrWB93lhrIjf4weB2dDa/oRSkhtTt
	LN628xMJ59ankty6Sa4iVoPKp0FvN0k=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-uoN8wBm_OHqUxoMud1R-Hw-1; Mon, 18 Dec 2023 10:11:50 -0500
X-MC-Unique: uoN8wBm_OHqUxoMud1R-Hw-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4b6d979a77dso387526e0c.0
        for <linux-nvme@lists.infradead.org>; Mon, 18 Dec 2023 07:11:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702912310; x=1703517110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evLAdIe0JUCK69vN8gt9neF+11vcKJB0GVTlnE+cvjA=;
        b=vAJv16HF1f5mpLk5xlG0QLlKQf967EEtLN/ycRrhEd1LIXBIbW1ERlROzGte7yGarO
         0h2nDvcuIVXqFM8tl+hoQF2H0Z+QF5rG+DqFfXikeQM3HvZHC3DZ/rQkQp0jkdW+NtSQ
         PikQUmd0TRf1qibkH4SLqNDVhxgiNQPOkNx4ATCtqR9MVflmspp18C2vGJw0lt4nHoCX
         ZNoH/tOtzIjthCTl0YT+3Js1BSNRmMnN/GhidnAFqlOPYGBI+oqK6NLqjOB1J/SA5XkX
         AOZPlJ0npNx/QBv4bvU4tkxJ1azqF820m69iUTOlDx2Haq3JbDinAMAUkRpVwaml6cOk
         yk2g==
X-Gm-Message-State: AOJu0Yyjx9lSvPoBaJVzwDPLdpk0WXfKciQIsi6MUzyogFK2oFBIEzen
	/PNL9VrMbRqeaNhyESuRJsJMQUIHfMueK5I4lyvDSOV8o75EVclHzAZaVL7k/2ZX0D0ZufqSG3x
	+zk3OcsVVXS7Wc5Am2J4TSqWpDniw+1SqWVhtTcqMkj4=
X-Received: by 2002:a05:6122:2521:b0:4b6:c780:ac90 with SMTP id cl33-20020a056122252100b004b6c780ac90mr1406247vkb.0.1702912310164;
        Mon, 18 Dec 2023 07:11:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFs63OpZIjHYE+cVqsVlT2W2uf8f2uz8jMTrSjpauANqFGLXyJ0yQUu1PNqrEZAeog8/MMQuUbeetrKm1Z7BCU=
X-Received: by 2002:a05:6122:2521:b0:4b6:c780:ac90 with SMTP id
 cl33-20020a056122252100b004b6c780ac90mr1406221vkb.0.1702912309877; Mon, 18
 Dec 2023 07:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20231215143136.252497-1-mlombard@redhat.com> <ZXyMCcq7I0ZBNU-K@kbusch-mbp>
In-Reply-To: <ZXyMCcq7I0ZBNU-K@kbusch-mbp>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Mon, 18 Dec 2023 16:11:38 +0100
Message-ID: <CAFL455nBx_tRj3QDVXwU2pReoryF3bVfMvD1O+4YHDZzWnzS2w@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: fix sleeping function called from interrupt context
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_071203_086961_FF9129F0 
X-CRM114-Status: GOOD (  10.51  )
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

p=C3=A1 15. 12. 2023 v 18:25 odes=C3=ADlatel Keith Busch <kbusch@kernel.org=
> napsal:
> What async event occured to cause this? It looks like the only AEN
> handling that cancels anything is the FW activation one, but that only
> applies to fabrics, not pci. Still, that AEN hanlder sets the state to
> "RESETTING", but we only cancel work when transitioning to "LIVE" from a
> CONNECTING state.

It looks like the stack trace is a bit imprecise.
It's not the call to nvme_change_ctrl_state() that triggers the error
because, as
you correctly noticed, moving the controller to the resetting state
doesn't block.

The problem is the call to nvme_auth_stop().

        case NVME_AER_NOTICE_FW_ACT_STARTING:
                /*
                 * We are (ab)using the RESETTING state to prevent subseque=
nt
                 * recovery actions from interfering with the controller's
                 * firmware activation.
                 */
                if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)) {
                        nvme_auth_stop(ctrl);     <----------------
                        requeue =3D false;
                        queue_work(nvme_wq, &ctrl->fw_act_work);
                }

void nvme_auth_stop(struct nvme_ctrl *ctrl)
{
        cancel_work_sync(&ctrl->dhchap_auth_work);
}


Maurizio


