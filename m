Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F386C04A97
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Sep 2023 15:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QPBE9M799lADgnSMZdZr60RYooiDDm/bO/X9KjmjZSU=; b=WUJoatiw2sVlR+ZJjFTYEjsbyU
	HMtm2fETolmAQ4FqZB7pqhxN5uV/dRMGns2u9g+mJYo7hDEcV2TsowHrqg8yhLntUtIeEBQAazrrp
	Zf5EdZpyVTgrnOxCpSpPdNbkhJIT+FgK+UBGPh8tEfwUYC7Yog6m3OJr8+Mhxwn38jcIzxfnTr7io
	Is1NrwdB1Dbdh2P8Xt4g5tZpc3uGpi51n+lc88JR/lCBClJ9mILE6tkYnhhTOGVds15SPBPgeIsbt
	9UN1Mg+jKGIhwFDzrTTrvU2A66lopsOA9YFb/jjPekx9r5xsEr6M6yyY8iAcEjmtoK9NST+Q8ZRF/
	+hLYJ4Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qizFQ-003WGc-2z;
	Wed, 20 Sep 2023 15:36:16 +0000
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qizFN-003WFr-0K
	for linux-nvme@lists.infradead.org;
	Wed, 20 Sep 2023 15:36:14 +0000
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-49369d29be3so2848689e0c.3
        for <linux-nvme@lists.infradead.org>; Wed, 20 Sep 2023 08:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shadow-tech.20230601.gappssmtp.com; s=20230601; t=1695224172; x=1695828972; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPBE9M799lADgnSMZdZr60RYooiDDm/bO/X9KjmjZSU=;
        b=AktGIudT+isA6DHq2YIehVuQUqgm6RgRCSVecFOrw+icJJQmyKkXW6RJG6rgIM5YKq
         9y7/1B91Km9iMWBMgAGYZVNbUUQhj6HnmMPVms2FD+MTUThTkWAarAzL5VRqSxBCXdsd
         DAeLNMAoqVmksoxIyToFKEboxES3n6c05+z86g8ZC5MTHxsQV8Mx8nx4ITAeW4uUzFNp
         8csx8N84J+tVopiwxgvl2JAnXpAOGpdUlAfkQIpkbE+27wQ41/5rBbZATSFQ8gwhqWoV
         HZWTdmMq3WSnV1k6710M44UY7N1VXokjnbpq5UGRpGeFNiwhw6RUZdvu1Q2mo9il97h1
         1WuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224172; x=1695828972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPBE9M799lADgnSMZdZr60RYooiDDm/bO/X9KjmjZSU=;
        b=GAH4VdwlMoPyU/GjqIfWC+88cZGctXTteAjH7Y3iz1F4Mh63D6Zl5h/2RBW+1ECiYI
         Mapu1AmDGnPBSWqtoEaE5bYdafk8hqMFBXT2alSSbXK1PtVOfwvlKZ6kWMOUVVSR5VNH
         rF7UdNtKqJNRsjxH2i7wzBvIVJic1Hbyc1JvWlZ3i/Mqfa/kD4cCAlgpR25W96q7JK8e
         lU+KX3pQy4Jn1WoX4aOKDP8EXdMukk/VYm9yFOtP9NVv1BdxzwuiMt2J0R8EHKoTNKp3
         fQWS7ssG7nfaMCj+R6hFyBXbrhKHSUJUpJ8Vp6YfIE5nLE9xjzdPZwcj6FjzCY3+dxpy
         i5bw==
X-Gm-Message-State: AOJu0Yy0atoGEpDmTnb36bm7ZlzqfhlOu7eQZxMh2ZCItc9EPBzXBcAl
	tT3piwIF0VkvW5lm+6qaIcDoyr+LiXKgBnxENtUdVKjAqF9onZMf4LKxvw==
X-Google-Smtp-Source: AGHT+IEVEhvFcZ/9UJudvGIUqJ1cigvnaEIwxSHIVS9qAFFn0DQEvOiD0TsbMBWjeIMlmLMmpacBnMdwPsiyWGlu9GA=
X-Received: by 2002:a1f:cb01:0:b0:48f:f458:f39c with SMTP id
 b1-20020a1fcb01000000b0048ff458f39cmr2812730vkg.10.1695224171730; Wed, 20 Sep
 2023 08:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230920141205.26637-1-redouane.boufenghour@shadow.tech>
 <6596810b-103a-ff18-49b2-7ae5c8d01c38@grimberg.me> <CAEjkvFgh9nSbGs0sZOZZdB9TWOtx=i1XE0Q7XjL63fK7TLLjrg@mail.gmail.com>
In-Reply-To: <CAEjkvFgh9nSbGs0sZOZZdB9TWOtx=i1XE0Q7XjL63fK7TLLjrg@mail.gmail.com>
From: Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
Date: Wed, 20 Sep 2023 17:36:01 +0200
Message-ID: <CAEjkvFiHupE6tLjNyxLBTv1Mj76ddAM2zwDLHt5WyqOt-Pogsw@mail.gmail.com>
Subject: Re: [PATCH 0/1] nvmet: View subsystem connections on nvmeof target
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, kch@nvidia.com, hch@lst.de, 
	antoine.damhet@shadow.tech, valentin.brice@shadow.tech
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_083613_166404_1660B1AD 
X-CRM114-Status: GOOD (  35.05  )
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

You can find the path here
https://lore.kernel.org/linux-nvme/20230920141205.26637-2-redouane.boufengh=
our@shadow.tech/

We chose to put the information in the configfs for nvmet which takes
up the spirit of the "target" module for connection information.

In my humble opinion, this information would be better located in the
sysfs so the kernel provides the info to userland. That being said,
splitting the source of truth for the nvmet module into two separate
pseudo-fs could generate some confusion which would make it harder to
users to find all available informations provided by the nvmet module.
This is one of the reason why in the "target" module this whole ordeal
is handled by a 2-step procedure: first, userland creates ACLs
directory (since we can't create a directory in the configfs from the
kernel) based on an attr filling "dynamic_sessions" and then the
kernel module fills the info in a dedicated configfs attr page in the
created directory. (The "target" implementation is available in
drivers/target/iscsi/iscsi_target_configfs.c in the
lio_target_tpg_dynamic_sessions_show function)

To sum it up, I think it all boils down to the question: Do you want
to maintain some similarities between target and nvmet modules or
should the nvmet module go its own way and implement this in a
different way ?

Regards,


Le mer. 20 sept. 2023 =C3=A0 17:31, Redouane BOUFENGHOUR
<redouane.boufenghour@shadow.tech> a =C3=A9crit :
>
> You can find the path here https://lore.kernel.org/linux-nvme/20230920141=
205.26637-2-redouane.boufenghour@shadow.tech/
>
> We chose to put the information in the configfs for nvmet which takes up =
the spirit of the "target" module for connection information.
> In my humble opinion, this information would be better located in the sys=
fs so the kernel provides the info to userland. That being said, splitting =
the source of truth for the nvmet module into two separate pseudo-fs could =
generate some confusion which would make it harder to users to find all ava=
ilable informations provided by the nvmet module. This is one of the reason=
 why in the "target" module this whole ordeal is handled by a 2-step proced=
ure: first, userland creates ACLs directory (since we can't create a direct=
ory in the configfs from the kernel) based on an attr filling "dynamic_sess=
ions" and then the kernel module fills the info in a dedicated configfs att=
r page in the created directory. (The "target" implementation is available =
in drivers/target/iscsi/iscsi_target_configfs.c in the lio_target_tpg_dynam=
ic_sessions_show function)
>
> To sum it up, I think it all boils down to the question: Do you want to m=
aintain some similarities between target and nvmet modules or should the nv=
met module go its own way and implement this in a different way ?
>
> Regards,
>
> Le mer. 20 sept. 2023 =C3=A0 16:42, Sagi Grimberg <sagi@grimberg.me> a =
=C3=A9crit :
>>
>>
>> > HI,
>> > We need to list the nqn and their IP connected to our target nvmeof se=
rver.
>> > In fact we can have several dozen connections on a machine and we need=
 to know
>> > which server is connected to which subsystem.
>> > Currently there is no way to find out which machine is connected to wh=
ich subsystem
>> > except through the nqn.
>> > The nqn can be modified by the initiator , so for us it=E2=80=99s not =
necessarily a source
>> > we can trust.
>> > We=E2=80=99ve created a POC to retrieve the nqn and associated ip when=
 a client is connected
>> > to a subsystem.
>>
>> No patch attached afaict.
>>
>> > We=E2=80=99ve tested this poc on a tcp and rdma connection and it=E2=
=80=99s OK.
>> > For the POC we write to the attr_connected_ctrls file in the subsystem=
s directory for
>> > each subsystem.
>> > We=E2=80=99re not sure this is the right implementation.
>> > Either we create a ctrls directory which will be created on the userla=
nd side and
>> > populated with information
>> > from the ctrl connected when the ctrl number folder is created.
>> > Or we use the host directory to add an entry when the machine is conne=
cted to write its
>> >   IP address, but this folder is also used by ACLs.
>> > Or we stick to a simple attribute listing all connected controllers nq=
n and addresses.
>> > That being said, given the reduced size of a configfs page and the lar=
ge size of some
>> > addresses (ie IPv6 address), that would drastically limit the numbers =
of controllers
>> > and addresses we could list in this attribute.
>> > what do you think?
>>
>> I don't think that this should be a configfs attribute at all. And yes,
>> a single attribute is going to be unnecessarily limited.
>>
>> This type of information probably belongs in debugfs. It is possible to
>> have nvmet create a root in debugfs and build a hierarchy that the user
>> can traverse to get this information from something like:
>> /<debugfs>/nvmet/<subsys>/<ctrl>/
>>
>> A controller can expose different things like host_traddr and hostnqn.
>
>
>
> --
>
> Redouane Boufenghour
>
> Storage Engineer
>
> Join us at shadow.tech



--=20

Redouane Boufenghour

Storage Engineer

Join us at shadow.tech

