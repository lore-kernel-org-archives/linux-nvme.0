Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084E5C5DF9C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 16:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M9f3yQZj60yVuaPd8pMR9CqCXnRJ9uU/VM+B3o87UKE=; b=it6f69MqTAoaRGLrUnAlf19SIt
	IRylbnmtp+XlE9qdALvuVwpRn/Wnqx4YFMT9Z0Zj4oEgRWv3N2zWiWyUdiQXxvKtpDzaSpUAZt1vW
	P3tE33r3dmIde9mAXTE5eA3xiQurxCSGvMrP3UQBHYTrWRkpCTSgH1rAaNJVEpfsIm9jM2TTvhFed
	Djk7YmqlnVnTg88Sey+0o4w0CPj+x1Y1mvbn5onp/uc+4SVsbcBiN7AqZRuZeyam8Pd+D+6a098B0
	ktMGmddNBCme678aw3uvvhmIIPQSBxOONop/LijTR6c/iTNMw0UTxZn2WALcHCbq6soZ/ZRq6XHZJ
	QEwGy09Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyXD9-0000000H0zH-1u2O;
	Mon, 24 Aug 2026 16:07:47 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyXD4-0000000H0yT-2w6U
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 16:07:44 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-471eeac43bfso2893099f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2026 09:07:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787587660; cv=none;
        d=google.com; s=arc-20260327;
        b=XdZWh6tKnoE+3fbXfkZ4urgRB5wfZ9k0L6/HWMNSWORqPt5AzPbCdU3oaFu1shdNEN
         0sEgnzvYiXLeVt/I80COUDR2SwsxJnhXOW+bwbu5rNRUxgPgcYU70zoc8ydWqIDdOUHq
         2vr8nDz7NGA3JdIBx47FmQAVQGaC93h5Iy6HVYNCei/sHrEyx3lGRNHcpMQU3qFjneLk
         mjNu/kagh0SiVtoVhgsxjpCOlbwae8Bm+4mYCkHlTYritxJCPj/v6zc2YWJ0eqIjQPfY
         Pj/aLNRI4/O44edATtVVL/aujQ2GvUIpegCM2y1ZSq7hTKiOfiyq4U/PPOw/LIuCYI2O
         T5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M9f3yQZj60yVuaPd8pMR9CqCXnRJ9uU/VM+B3o87UKE=;
        fh=mFq9CjbbsXSIpalHr0kqCZDTRsPrwTaiKSTN26buXcE=;
        b=NcpheA4ZsnGz8Nvu2q02jWKGLfEAWdDZG5RfZicYKK6ojiVkP+kiswI535A5rWYjsI
         1chCmNltZAQ/2+napaSJ/2zG2WyANrftFOmWOQWSryH2tgy6ZlRd9rxMo3O++O2iNRIy
         DKMK349IiVk5AaGguH39kxAEmrc/geF/eU99/aId7PWy4C81YrMz0rQnUC+8znuP/jA/
         Duc3pNZWg96Fw7fOErAM9AKPfWo6Da8wFJLjzGlfb3A9dajsAFqSu3M9Kgk4bUuQdExg
         tzUSv/Xz5t7BmUVfUKWfVo9iGjaIn76Qcb8SuQIT185On+vsnnRwR+dXCEJDhH/0cKLn
         0w3g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787587660; x=1788192460; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M9f3yQZj60yVuaPd8pMR9CqCXnRJ9uU/VM+B3o87UKE=;
        b=S7XPMwBVhytvVOQmIr7c+OCmk9v2ZfkRqmeYahlpj5rFkZt5WbMcDq8HhhRRjP4bZO
         WU5R6LPP/qCh5dBO25weublkXlygGVq3nl91zYrMY/4CbJp24vet0KCrqXPraP5Yzfnq
         aietKnqcxp87d47Vk8fcGFzG7B+zMuL1PKir/OcOmg5q+DMQFNajuN47fJqtHnHZi81z
         tWpg9Uf1JgzG9A+1bYFCvCakwyyRqIiOjMQCURHEsqWQwtaDWihzgS0UoJoORcBaeXlW
         Isaz2Sklo+YYON+WPgD02jhqtnhNFAbcSCjzwdDsYkYe9EZBh/zr0sXTYZZzBYr+3YHi
         5lrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787587660; x=1788192460;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M9f3yQZj60yVuaPd8pMR9CqCXnRJ9uU/VM+B3o87UKE=;
        b=U6Sx4mMeSz361SDCm2MDz36/svsOlYCu7Dzsd5d2mLgbcJboRYObuDcmoymDGN+vVF
         iHcKxe3JrSy4RGXq9UopPB/yS0m8Vsk7lOcPFmt4YzZlt8uh5XDJUn6gNBCjPBPM1pIP
         EoihfC+CJBJxn2kGoIAZ+J6hiIWNI1kogbA6JDwMfMkiJdQg/dUCpGBGw3gWR0uvDVEP
         hHT0tHIwPJrGEKOhu+Err/vdiCenMvRaeIZ++peyh6C9xYP+q1RzZY3WNrxRa51RD353
         0MbQXHG/Mym92DqQMbEg6L9MtefOZu6wahwy8vvce0UkHDzPI1m0v71Ao2ThScOS/+6d
         nypw==
X-Gm-Message-State: AFuF++njsQvzhLBqFEP9g2evXf11bQSKvMTlJ7nKvKoeuc+bKmzprm+L
	nEH+bYA5p2K/tNWbHzip8ycUR0BWHOVs6m4T+AkAGkSToyDD+N2E3fbmtq/vY+HRYvwCX4Ti/LC
	90mAhE6MddejGq72t+W25AN65b2Es+mA=
X-Gm-Gg: AR+sD11EVebaWGImCQV9QZ2LU029Pr6robGoF2UHRqZpJCil6hmFjYlixK/a9yJOYJu
	vAmn7SbaLKJVkLm+2IiE+VaGj856yhytjIi8njyB3DUjfuviSZ51rKo0BfxbVtNxQaDnK6pRhHX
	TGTS579R585b9wJ6YZJXcbST0r0CMXl5E7BOH/BliptSw9lvY2Bdwt+eUp9UymtcJSa8zLL/ypc
	pB/YYspwP1aBDImSk36hTLFFShvZJ/iZaxI+5BrL3zKVxlpdp2TwY1Vns80pZm/Y2igeXwDGfgy
	jTMRVCwjclQVIjpNn2eZPwa/dRJyVvrn4xO39mKQ1bzcor+ldOMaKdm3CA==
X-Received: by 2002:a05:600c:46d1:b0:492:4e09:9fc1 with SMTP id
 5b1f17b1804b1-499c19dcc4fmr230504345e9.15.1787587660187; Mon, 24 Aug 2026
 09:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <CA+ysrSKO9ufMWQ=s_xM_uh1OhKmEb8v0tOwYH+g2vtxeWqW8DQ@mail.gmail.com>
 <2026082412-matchbook-perennial-03af@gregkh>
In-Reply-To: <2026082412-matchbook-perennial-03af@gregkh>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Mon, 24 Aug 2026 12:07:28 -0400
X-Gm-Features: AcwNN1UaIzFP4jNdRTIzmFkFfFf3fY3hKCWo0kI6yqf-GfGOrz02uwbHpDwtJrA
Message-ID: <CA+ysrSKxTa--qGNrZu5SPLner+OTvHYFjfuSRnFW+xkqnQ+VBA@mail.gmail.com>
Subject: Re: Prior report for the nvmet-tcp unbounded SGL length fix in 7.3
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, Ibrahim Hashimov <security@auditcode.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_090742_758647_6162EA59 
X-CRM114-Status: GOOD (  19.44  )
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

Hi Greg,

Just the CVE, if one is assigned to 4a3f002, being recorded as the
reporter would be all I'm after.

Thanks,
Shivam

On Mon, Aug 24, 2026 at 12:01=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 24, 2026 at 11:42:50AM -0400, Shivam Kumar wrote:
> > Hi all,
> >
> > I originally reported this issue to security@kernel.org on 2026-03-17
> > (Cc Sagi), Message-ID:
> > <CA+ysrSJUFi8cHzU8g9Nrbbkcuo0F7vh8CMn3ht15gSk3BbK45A@mail.gmail.com>
> > and posted the first patch for it in this thread,
> > "[PATCH] nvmet-tcp: bound sgl->length check in nvmet_tcp_map_data()"
> > (2026-03-19).
> >
> > Commit 4a3f002 ("nvmet-tcp: bound SGL data length before allocating
> > command buffers"), merged for 7.3, adds the same NVMET_TCP_MAXH2CDATA
> > bound with the same status code.
> >
> > These things happen independently, and I'm glad the issue is fixed.
> > Would it be possible to get some acknowledgement for the original
> > report?
>
> "acknowledgment" in what way?  If the patch is merged, what can we do
> here?
>
> thanks,
>
> greg k-h

