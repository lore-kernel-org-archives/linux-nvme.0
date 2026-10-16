Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B361CCC6B38
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 16:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gPXFXTYHfhMIi3Tk5OWQVDYZ9+5PmV/EuJNrX3blnmE=; b=uUIFE1ZiqzAZslknWgSb6cPjDP
	BOWHqE5VaeXJBaorZTc4p2HpjxxHzZNlPYuneI8H/rWSEhnLwSSccPXYFcNjAl+VyyRWGSJIxpna4
	2WzICQhIOddy6PkFeQlLyqzo57zczOhXyc7J2A7S5bXMjs3oJW2qlmA2M9MqMqzNwwthcKGtskdgm
	roP+nNQyldaQteE3kyBb0/FVl8Y/F47pgGtr+BsDIE7dH1YEDNiv0vIv/CpPQtAZG5VevEXU3JkHe
	+InCCZ+9zQYjTvLACTq99DeUkWj9hd5LonXco6YghZ37uplCVDHCsWbt1jxmifoappvpMNRvpP1wu
	8PZ+HBSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkXJ-00000003PCI-1YwD;
	Fri, 16 Oct 2026 16:12:01 +0000
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkXG-00000003PBw-35tV
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 16:11:59 +0000
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-91b54d1e9cdso1276466d6.1
        for <linux-nvme@lists.infradead.org>; Fri, 16 Oct 2026 09:11:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792167117; cv=none;
        d=google.com; s=arc-20260327;
        b=ko/nWKtqDfzRCD0PvuiVUp8rl1mDPhBZfSeGEejtaoUSpemZ+PLIbwwv6CeW2MGR8S
         Bj9J6cJrqtf4t//KiaiMZx6NtK2XRcJ90EyYxJ8Jq893NyPOiY3dpBckqnOQ5gJkb1eO
         XzJ55BVV+uFah7TfIfG3drT8gRTZva1YCHli3mM+bkgdH1nbogtP4MzqIfkfw3235YqQ
         2jlmbohN3uy15zO+goegwJkr5K0oPIrkyrFdyYqJwBXTij40WyvZOCecWyMM2FEo5Rtn
         1CYdoRjyQUjm7cVoADKCWyTipnoM3Hi7YAhNmzVj2Faeuy1kN6CtXKxd2ObywtScVP6a
         nDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gPXFXTYHfhMIi3Tk5OWQVDYZ9+5PmV/EuJNrX3blnmE=;
        fh=yR3KGqvQXSLjMgEuhWgAabiXh28Pdd563S70qNNZMNc=;
        b=AHawkEN5Y7M0g9tWAZBQQ9Jc58HxmY3icfIhCKwnRhat7CdouNQ/fMWMp5G8vdfmK5
         91PxjPXIF61uPhE1rlnIgIY5859aLz8t48VKYwz4v8qk+nVIlSPaN3YcpkUpSzDPPLct
         bDyIgHeaA5t7dZYtDAp7YdFeEa3KL4hRMbvZiR4dUQiUTdoDawUIcemjb4vA0F4U49MR
         bdg9AScB3vnR4OVRt+WHPZMOvhEyj6UcyV/UoWJqaf6cLmWGCrhXydNNymC1QTNgV+jc
         ExA0BLkSZNHHfHC5fN4S1/EJxd/kXshfGrbwzbq/ejp1IEWqf5hjSe5/nxsWmt4yjsyx
         4LTw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792167117; x=1792771917; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gPXFXTYHfhMIi3Tk5OWQVDYZ9+5PmV/EuJNrX3blnmE=;
        b=WNcIRQh6URAUF3kxL6hRRz924Tk5zj9y0+/qY6H/VAUF5V109DkZE5GEyy5FT8nf20
         J4KRvqxtbBwG1h/8MLIA7Xy/Qz1NATcHFxsZPBtd1J3Ktim2C0qVcwn5NJPJNFgTNS97
         UA4HD39Ji2oIAwtXBHyAX+8D8ONiGHuv7cIH7g21iGgTt9Fpgyk8xeeL9CMVn1QI/Sn2
         abql2WhZfUGq+2YU3yr+XAJ4t/7HQCb7f1SJf8BsFUZJ0YJCP+AE+nuPvtV2EfkEpyzQ
         7iOoIWC9ru5uQAJF9mM/3VrN93nKvCCf/TTxaSA3DeQvL7i2wYYWYdzQSSLIAQ5gJc1A
         +bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792167117; x=1792771917;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gPXFXTYHfhMIi3Tk5OWQVDYZ9+5PmV/EuJNrX3blnmE=;
        b=jFlYypUd9KWSLnyGr5z1wDoarASjD2V1W+SMW7xelWOB/1cN7uJi5X47DtKmwBgJSq
         bb3tJPHREBWCdDQRdyOmldmSMZTym/oYmwQeNmpZ84J9YPCvwqwkOx0UenmHpLJ1IwjA
         Q5a73nZ7opxB+bdgiFzxYmj4ypJFAdjQ68RKGG4wRtER0KeByKlc5t9LS8QcepvUl8Kg
         0JGl+9SiSTOs1pweJfBM3fhvhMhMBEIK7OvAxu+jqJ/qjwFGf96+elTmfl1b4ls62CJW
         6gDy46Hoon5OPabfRMXoWiJPev0BZ2EUtH1ZYWM2Sg+fIjrLdDJjxWnmEe2UhSU6nGBJ
         fBUA==
X-Forwarded-Encrypted: i=1; AKwUvBy4tmFq9EQo/4DURvGBlWtqWwR+PExICifqQlAJKG4yaK+NWikrGfz7BD8Tx8/tq4nLZKO/9OouRVuB@lists.infradead.org
X-Gm-Message-State: AFq9FYIYGy6/ueQYkOUR3lDBeAojCVEn9SCu5xztbNz/ZHP0KVyqRsna
	jr3DtXJhtr/mA1NxLQoMSw/Ryo9LRCOnOZDoEtq8qE7+S7fa/QSrbweWDyRoRkqR9EtNwc5ATOg
	BSeyEbAtikIH8dlYcSayz+9K6r378Ahw=
X-Gm-Gg: AYBFou1ZdrmWe72AtMyThsCaM+47xsaO1vz18UmiFxISkd2OYkh107TfrHMWraNb7ja
	STSPKpFnRSsXKeacSV2NAI6Z+QMDxKjK+uExlYi3kPY8NBATdgTRuZhjnzo2MErnaOEQIKtr2yK
	Io/GXYi+484cirurBYvZyzHyWXXGK5df76Dd+z4edFAIq0jL3XBZUY80hCE2gb2LN3TfpMwTqmA
	puavD94zAipRas8APARBjlbV5BhzsoO5jGLdtThXa2kX0wwVtaaW4pFUrm5/YZtIhLNrk01kCR2
	AivnMpr3orjNAtopsBHx9J4sgmlSsPWiwYHE/pXcxEK4bFU+l7NKSBi0wl76ElC1Wru5tGreFI9
	Epafg1nyc8Id0DM/2SGveyflOFddqn+i+yrIH/ByUoQT1x7ciFVFW6yVjus8jl8Nrepyiz9dYbQ
	==
X-Received: by 2002:a05:6214:451d:b0:911:9373:a171 with SMTP id
 6a1803df08f44-91bdf14bd10mr7504466d6.30.1792167117094; Fri, 16 Oct 2026
 09:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20261016155947.11018-1-neganhat@gmail.com> <atJLkogz_looz_I7@kbusch-mbp>
In-Reply-To: <atJLkogz_looz_I7@kbusch-mbp>
From: =?UTF-8?B?Tmjhuq10IEFuaCBOZ3V54buFbiBEdXk=?= <neganhat@gmail.com>
Date: Fri, 16 Oct 2026 23:11:43 +0700
X-Gm-Features: AclHuK8Iwg8EbtvN55OnbeHF8C8q8dkZtGC1xJ5xQYF_Zpjnogu2bBvmMmbRg1Y
Message-ID: <CAFJkwZyX6==NCJgvgptD8C8AP5YtiLY=B8M5zacNYKxGXqQYnQ@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet-fc: skip port entry rebinding if already bound
 to a target port
To: Keith Busch <kbusch@kernel.org>
Cc: paul.ely@broadcom.com, nareshgottumukkala83@gmail.com, hch@lst.de, 
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+be62d4b375542ecebd17@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_091158_807787_F20E4B75 
X-CRM114-Status: UNSURE (   7.60  )
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

Sorry about the noise in the recent patches=E2=80=94I botched staging the d=
iff
before amending. v3 has the actual diff moving the check above
nvmet_fc_tgtport_get().

Regards,
Nhat Anh

On Fri, Oct 16, 2026 at 11:06=E2=80=AFPM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Fri, Oct 16, 2026 at 10:59:47PM +0700, Nguyen Duy Nhat Anh wrote:
> > v1 -> v2:
> > - Move pe->tgtport check before nvmet_fc_tgtport_get() to avoid refcoun=
t leak.
>
> You may want to double check before posting new versions because this v2
> is identical to v1.

