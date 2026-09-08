Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D329C79F99
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2026 17:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sk3dzC0O3i8KQ38cBkHqmRYQTMPuP4JXDDQMp9sD7lU=; b=Ac+Pqc/IgVNFmnZ4VwJ4eFJe4Z
	dc/qmSZxoTbK+i8ZVvH0PimOqHmcHtc+WvUDVayu5WOsyM4QGuBIFPQ4EEPl+R9L2uD0xNiPho1mX
	i7QGaTt9/vt2wS9jHCNBDcFtxX6GtzxuyVXYlPK0NIgPrnzAhFfsZkvH7vJQzTbQH4asycuEfK61w
	AGFNKl3+T4rYFnf4hQrraozjrC1V1vD8+SvAbJNJVZ1Vxezthf2rnTlTU5VZgvC2zNdfC3NGKLLMB
	Y2eMIarawrK/SdAiTwebxdheUZUEjWfjaGArhReQ8G2RZFwkdxsgFB7CPcvC7qAn6E7J6M6NLloi9
	7+/q4x4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3zHA-00000009lCf-0NSP;
	Tue, 08 Sep 2026 17:06:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3zH8-00000009lCS-1NSL
	for linux-nvme@bombadil.infradead.org;
	Tue, 08 Sep 2026 17:06:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=sk3dzC0O3i8KQ38cBkHqmRYQTMPuP4JXDDQMp9sD7lU=; b=gKHCaRetpRdGjA6R/UuBImgbna
	hXV2EZ4aFrJMxh9nSYIzc1R+3cU8jcY6wttWfHRjVB4LrteHi5XMvHMTyPATUmj7hoUSjeIqDW+HW
	YGBbp37kqPH3S5yt3ZFVQYNVdwfcwqRKbPJrSpyJ9xfv0O1rZDD1kM+U+1TJkZSmkejZI/rxsrvUg
	h4neo7Phie+TV9Xtva5A/C3oNFUWRoNS5TWZQGLkP6zqITescjKUqETvMvESdQpuyYar6dDQvYQ6M
	Q6eipWyRz6eLJ13kZ77FEG40iyLBoh9b9e9Z5n3Zcj9ZHvYIFP+aC/R3Ma8WZnkVrU77kwJR06GV1
	JOjwZA6w==;
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x3zH5-000000008Jy-02a8
	for linux-nvme@lists.infradead.org;
	Tue, 08 Sep 2026 17:06:25 +0000
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-97cc20c05d3so1308474241.0
        for <linux-nvme@lists.infradead.org>; Tue, 08 Sep 2026 10:06:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788887180; cv=none;
        d=google.com; s=arc-20260327;
        b=ql61y+r+FNma6gVxamfdJE6oiv7dgBqIMt8llkhIbLr4/3EO7aEl4fuXW5EV61oMuJ
         a0zUQfjbUQk1/tk236AbqHHv2QKbWBuBLHFdqeNWNb/jIh+wJ0eYdhL7XxEjJJc6gQG/
         JSIlmf+7s5V55kOyMl2fk3Rgel2Qlx8/NNOgUdfCwyPhgNsd+GcwjsJx3YyKjByINk8v
         0IlMOBojxBdUmnmw0cUV7Kp0evkhvfQ4vy68RbjyxpfrJYhm2jJCaBb8lFaMP7hKdr9U
         WGopXpbH9EPBNWhOVM07nbaMKMkNMfAmW0o/YiErVAGLu3q8sxzyRmlgW6yamye46Lq/
         m4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sk3dzC0O3i8KQ38cBkHqmRYQTMPuP4JXDDQMp9sD7lU=;
        fh=E7HU/JOBXe61Rj1MxbKy+4My+pIQEVrLr0DJnSomQms=;
        b=bVxKsCotbYZtj9girQc9XjcKvRtHLwd8HAYfxi7DIO8yD5FNCHGrQJ/tt2LacJqFT2
         nd19RGOrOda9Yw+gwQ21XRVEpdmz3p3TMI+v1MVMg9PnIfVvvB4lBLIgFZ5EtTpLlGjL
         BoXUBFxTBHtzYmqedZQ+yx0CKTcyC6KwkZom4zPMiGASI2UI9ew+vs/ImFsPSxEiqFEd
         VzQafWfDtdf1x92VEKK1BX+mJ16mjdBbnkVw/BDD606dFkHwhLe8sbj7tCPO5fClsI27
         vr/rRSpfIkSTKEfq2zourd1ubH3qsWtWwnHtXF0Bsnlk6rNQ5pq4mUuuYq66JlGxUo9U
         Gypg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788887180; x=1789491980; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sk3dzC0O3i8KQ38cBkHqmRYQTMPuP4JXDDQMp9sD7lU=;
        b=KR5lbRknm5L2e4WDSGBb31oSM8wPrlSUyiD3SphjURnlogtoJDXxphOgnmBldpJHlW
         2tVBIPY9xRySGbjgFB0wXoiQ077cf/W00DSIeXoT+W9Zh7eeZ7yZYYVwHMBIpiMZk3xV
         QZ6hjle4r7d/O/xOBJAeyUvRUNpyrlUlBiY5tw/8F+8ubjwhaHm0BEVDndd0eRAhbA2N
         5URMNDQV0HIJrEYEZbO7UouoqhxC2v4aoFmQKXDKSNn4BLTgyENreAHwwymZe4mZYqDj
         DhdhQg/tuGKh1HBsDpPvblMypql27w29s8AUBs3pwOlZHiuMsjVrQTo7CwWjD08OHPmm
         hiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887180; x=1789491980;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sk3dzC0O3i8KQ38cBkHqmRYQTMPuP4JXDDQMp9sD7lU=;
        b=WFYCEN4Pj7YuY5m+hXftJ1PQBdkc8LXr/VN/jAMdVvyx1hpsIGIc1FbE+vcFSbWyCw
         tU6PDTPgHj84/5RFwzOB+4QP2txiqUBfd8Vlxz0JQ7dCadhfCZQhqeV7ZedwGiKzrMnT
         zfEkVbtnSX5dYiOfK2JQmLN5sxMTEQylGR7rAdF8/+dIkH9Yi/bPSf9rlA0h2xVPPGu3
         wb8wxD36hCB5Te5imlte/7mGPt2CacCMUT+LdQaY/q7L5GPlaIibhr+cqISfCwr3HMdu
         NOWQhZ4jvTL4FClPbu61bqS4grHmUv980xK87w3I9wWAowklIN6fc1JpQ/BHJKi9N7sA
         r8jA==
X-Forwarded-Encrypted: i=1; AKwUvBzrdM1gDx2iDa/N976+/DQREoXiGH2yUEdEannRv26puANLcL9zGRowaI0/tGGLEBphpXOXBkXomr9g@lists.infradead.org
X-Gm-Message-State: AFuF++khxuvVfWCx73YfSgWSk73oc5OLbq8crXJIqsUAcLu16FPxrOfs
	QM16atuuBUUZ0XtA1ubo2qwn7RS5t/MGI05xo9tNmXMmSqaX/X4m6DQnMdBvy2nBh/ZFmduoaq2
	X5ahcf/zVfKgC/9jnigzsyHx+i7w619vk4VkBaaQoog==
X-Gm-Gg: AYBFou0wKUZNwdSn96aJU6YmTILSluvB1QGVAcnjdlcKUvdf8GJBeVF46NG1PvlYP2Q
	W2cQTpEDyeUkK06jDrG0vTdXJVPMt5KgKi/XiiXdrQ3eM8ED6E16t7sFuCvYGHz0W2amUm5+X/6
	7Q7xQxUl7YobgI9KCwSEnQBzyADO/MCXIn54W6TH0BOy/0UBj3A7ycbrUsxIzhbyKNaqbTrIOiY
	gTJhHfakYV0xGIADzcQButnTeLY2c3cn/FzgnowOGIvvJg6KwJUDwVBSV7P+w5+wOsfpHxle023
	xfiHh4fMLllGNLCCADbOnW6HBZCe9jBPgvreq/HMf3XOmQ6JFq2pUqek6PgPr0CyyfHdYAqYw+s
	EC2OJ5NBAak1ZO+hIoXMzM/RsJtzDFjSncs/61IhV
X-Received: by 2002:a05:6102:508a:b0:779:dc0d:2b2d with SMTP id
 ada2fe7eead31-78a4a917628mr10388340137.8.1788887180099; Tue, 08 Sep 2026
 10:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260815173502.1185929-1-nilay@linux.ibm.com> <f0215fbb-0e96-48de-8c6c-dd391fcf1d56@grimberg.me>
 <8ecbc5aa-0a5d-4780-9c34-bf433f5e6221@linux.ibm.com> <2a03f032-3fed-454c-a960-ac332b4c3fed@grimberg.me>
 <77d16701-c829-4fd7-bc4f-8fb51138d9d6@linux.ibm.com> <e6397f5d-b565-4219-95ed-4ace5f23c37d@suse.de>
In-Reply-To: <e6397f5d-b565-4219-95ed-4ace5f23c37d@suse.de>
From: Randy Jennings <randyj@purestorage.com>
Date: Tue, 8 Sep 2026 10:06:05 -0700
X-Gm-Features: AcwNN1UX57bNXjdrUiWmqfWLd3sDPRyODzb1l8AT1VebYNAVDtSVYK-NU6EwXqA
Message-ID: <CAPpK+O1QZKcab57unB2AsSMpPXHNVNHGarAXba4vvfYjm92=2g@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] nvme-multipath: introduce latency I/O policy
To: Hannes Reinecke <hare@suse.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de, 
	dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com, 
	martin.petersen@oracle.com, john.g.garry@oracle.com, gjoyce@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_180623_240328_AE5C1B61 
X-CRM114-Status: GOOD (  28.24  )
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

I think Nilay has done some great work with the latency scheduler, and
we have it in our queue for evaluation.  But we have not done so yet,
so I would appreciate if queue-depth would continue to be available
until the latency scheduler has been more fully established as the
prime choice.

As to round-robin, I agree it would be great to see it disappear from
all of our customers installations, but I have found it useful in
evaluating multipath failover behavior because it is easier to reason
about and construct the test cases.  So, I would appreciate if it
would remain for debugging only.  I would certainly be open to a
mechanism that made it a little bit hard to set round-robin as the
queue policy, though.

Sincerely,
Randy Jennings

On Mon, Sep 7, 2026 at 7:31=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrote=
:
>
> On 8/31/26 8:31 AM, Nilay Shroff wrote:
> > On 8/31/26 3:23 AM, Sagi Grimberg wrote:
> >>
> >>
> [ .. ]>> I would like to avoid introducing this as a config knob if it is
> >> always behaves better.
> >>
> >> What do others think?
> >
> > Good point, however my view is that we may not want to immediately
> > deprecate or remove queue-depth/round-robin. Based on my testing so
>  > far, across a variety of workloads, including intermittent packet
>  > loss, the latency policy has performed better than queue-depth and
>  > round-robin. However, I would like to see it evaluated against a
>  > broader set of workloads and scenarios, including cases that I > may
> not have considered/known.
> >
> > Once we have broader evidence and establish that latency consistently
> > performs at least as well as queue-depth/round-robin without any
>  > significant downside, then I think it would be reasonable to consider
>  > deprecating those policies and  keeping only numa|latency.>
> > Until then, I would prefer to keep queue-depth and round-robin as
> > baseline policies against which we can compare the latency policy.
> >
> > But let's wait and see what others think.
> >
> I think that we can deprecate round-robin now that we have
> queue-depth and latency.
> But I also think that we need both, queue-depth _and_ latency as both
> latch on different properties, and there are use-cases where one might
> have workloads which prefer one or the other.
>
> Having a config option to select the default (and possibly disable some
> I/O schedulers) would be completely fine with me, too.
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

