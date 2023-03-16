Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E9DC6FD1F
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Mar 2023 08:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BJHrIm255WNgeiZmGtqnr5U3TJCCaby60NVIFNnbVKU=; b=x5bF1sB1eXIelS7GyhsN0mxanF
	wmDA+fbLFqoXwL8i/gKo3nt8w/a7TfDRf5A6eOtvUFxRlg5D9dqyC79Lvdi8B+1qT3fhAW+4fB1rc
	vcehj0dHym8qh8JaxNN9PseWT2xnkTd28oHpx7PFmdyd0cJ9E4VmcOaGFI27OLA97LPjSc2rQYihK
	u3Wnn2PvbrlBb1hc0fudNrQPjnrbvwF5M8edVHOkSYCAl4JpjUWDHbYaKFSgi/9ShW0R66icf1icr
	vVpoktZdnidiHU9gW0hkRqbVVHMRwl7ZbQwgZtv8J8FftaolVc5Ai1yzFW4lgjYwAf+7muO4EgO4u
	6FFcKQHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcj42-00FgBW-1L;
	Thu, 16 Mar 2023 08:34:22 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcj3z-00FgAU-23
	for linux-nvme@lists.infradead.org;
	Thu, 16 Mar 2023 08:34:20 +0000
Received: by mail-pf1-x433.google.com with SMTP id c10so621188pfv.13
        for <linux-nvme@lists.infradead.org>; Thu, 16 Mar 2023 01:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678955657;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BJHrIm255WNgeiZmGtqnr5U3TJCCaby60NVIFNnbVKU=;
        b=eeL3qEW4UObtZlyPdHGGpnFM/4Pr1GQcGy3fSlh7IcjbakEE84qfZMm6PDl6M2vwhR
         GbwZmE4FhYHypdQLUNGRITHV+UQpufEHXW28yjKrMiCRzoPnnRPVrP1NKzs7b2t1AueO
         FpXjnYEr2HXSFc7I4JbH++cvu4Pq8NBYPsLWIp0GO+aGxI6mpKQlJA5lSATFgqFFIsrs
         8rBOHcJutOsIJRKfvjMKZ0Mq6pQ8s7B2oOwMNIciDYkw3EwUMcincakISD/Q+Pu7LPuQ
         HlWWCEUu0utMhiu0E0/w0PkYC31mwO9XwmmtdPsmAnz6GXTRK5uokQltyr6Hk8K5/aYz
         PK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678955657;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJHrIm255WNgeiZmGtqnr5U3TJCCaby60NVIFNnbVKU=;
        b=Jt8MQIZ2/AibQe4VJwVdmQczc0/aUGVLjZvc8dinmf0cX4xRK6WiQG4rvW34aL/9Be
         Hab2KkRAhILCg5yQjQz+oKirJePac7xfmtF4ULAG1yWr4b5+k8Q/QWGmyH63XSNtNrSp
         gmkvhHw58FfJ8MFtAk5PrIzE2fi9EZW4+pzqvrvmGyPyCADu8Zm9mkzY6ZRGE4eDSnkf
         hW+MpmfnvbA2gglUzrs2ZgcCPVjxd9jvIPKHAlaHDJDbtu56LUiP7LJ2qWotYIc8isvf
         mBYJmmXM4HicIQG5SIES2iRejtwNzsrxk54KmmYGwgStXF/Bm1Pq2ZNcIbzWRidFe30E
         klDQ==
X-Gm-Message-State: AO0yUKW+5MosTtXQJhkvcFpiWaylIW1V5j3RxKk/hKGh8YqWuj0a5Smh
	AG0AbozMI/6NFzKTkDqfQjQ=
X-Google-Smtp-Source: AK7set8v7ywg2HKnYBRUnAwTK3+rDxsrChz02q0uWG9FssgJHyw4hMVeCrWEyxbFwKqyrM3k1k2mzA==
X-Received: by 2002:aa7:961a:0:b0:5db:c36c:8036 with SMTP id q26-20020aa7961a000000b005dbc36c8036mr2250891pfg.9.1678955657596;
        Thu, 16 Mar 2023 01:34:17 -0700 (PDT)
Received: from 10.0.2.15 ([171.76.80.150])
        by smtp.gmail.com with ESMTPSA id t21-20020a62ea15000000b00571cdbd0771sm3059288pfh.102.2023.03.16.01.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:34:17 -0700 (PDT)
Message-ID: <837f9ac84157523acdf65cac5a620100e74e8ef6.camel@gmail.com>
Subject: Re: [PATCH] nvme-core: avoid identify with CNS 06h to discovery
 controller
From: Martin George <martinus.gpy@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org, Martin George <marting@netapp.com>
Date: Thu, 16 Mar 2023 14:04:14 +0530
In-Reply-To: <ZBHMf5qBgsbhtk6N@infradead.org>
References: <20230311172603.3800-1-marting@netapp.com>
	 <ZBHMf5qBgsbhtk6N@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230316_013419_721663_27BF51E8 
X-CRM114-Status: GOOD (  14.55  )
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

On Wed, 2023-03-15 at 06:47 -0700, Christoph Hellwig wrote:
> On Sat, Mar 11, 2023 at 10:56:03PM +0530, Martin George wrote:
> > nvme_init_non_mdts_limits() currenty invokes an identify command
> > with
> > CNS 06h to both discovery and i/o controllers. But as per the NVMe-
> > oF
> > specification, this is not supported on discovery controllers:
> >=20
> > "The Discovery controller shall support the Identify command with a
> > CNS value of 01h (Identify Controller data structure); all other
> > CNS
> > values are reserved."
> >=20
> > So ensure this identify command with CNS 06h is sent to i/o
> > controllers
> > alone and not to discovery controllers.
>=20
> This looks correct, but can we go a step further and also skip it
> for administrative controllers, i.e
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (nvme_ctrl_limited_cns(ct=
rl))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (nvme_ctrl_limited_cns(ct=
rl) ||
> > nvme_discovery_ctrl(ctrl))
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ctrl->subsys->subtype=
 !=3D NVME_NQN_NVME ||
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvme_c=
trl_limited_cns(ctrl))
>=20
> ?

Sure. Will send a new patch for the same.

-Martin

