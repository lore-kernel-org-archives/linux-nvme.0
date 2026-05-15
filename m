Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3370CD37AC
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 02:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HjuJ9mHs8BUnwhNge84Ub4CU+c74Kq0XaMXnsU0zEXw=; b=vkVI44AR7dvfzWsS9hLJObdLLb
	5C6S6Y3VSqDd7B2DDFdYnzoV0oejPd25bjxpNbeMYvE+n4B7H8JINohFTuomqTaKg8tpZUzQAIpEP
	528Sekr/YMQNETIuhSUiF+5K7gKpbvNVi8fVYMwZeN//maVKRLKNhCuiDPXnzhQLZ535zXcWZ+1xP
	KmElAkr40ZudYKbkdwZdW9Bxb3inR6JR+jkwReaSuLohSXTiYFJ1upjtSVUiPy1Gxu46ArH5hO+TX
	5ALXhgGRB+Fka0u4MH63sNLzBTEfpGB4aInHyUvwN9H+Um+ahzPPC9s+sjSxXJEqjTEHL6YaVkIFs
	aiawp/sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNhwu-0000000751h-1FIP;
	Fri, 15 May 2026 02:06:48 +0000
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNhws-0000000751D-1u9U
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 02:06:47 +0000
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-632e479586aso3815186137.2
        for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 19:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778810805; cv=none;
        d=google.com; s=arc-20240605;
        b=IQZIbJhegEUACXRq766IX/OqtFg4Po0YAgcVV+mH31zOSmQvl8f9/DXH5z4wfJ3heC
         U4PZEZFmM1PFYTULhOgsYFcb1FwiOk/IOKQ2vDBfUP1P1atyYLe+Z6hIPxTCRI/+in9D
         PEVuoLqNiLjnrlitRpQ8gHJl1peniVle+5RKfMPN+Z3oc+7Y/VzZHrpLX1MtQK7j2Epx
         tiqWC+KEr1xUiLTxlbhUwa8F6xOxYZgqkx/L3xvy1n7zMkFtG8c3b4h9zY9mLWBNRBN+
         Jtd3Kf0ho5lxXZ7KUyggZ26zB3GGN00DS7YlYVecyFaruvgF9sUO/RkjrO4JfzI/RCq3
         +1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HjuJ9mHs8BUnwhNge84Ub4CU+c74Kq0XaMXnsU0zEXw=;
        fh=DN8r3etVJhwjp52CRmz5BGPb7Y/np0q4YLR9mtrNSI8=;
        b=Bw6XH7iyTIBL+pwVKL1ZvEVll5pr0SPhjbr664jIEGm3rLSp2OMd1i4B/+MYsfjWHh
         VzdprfPa4YYh5j4fFyHraN60CalF2kPvpsgl4ikOjMZiJa847hIFy4NoZjaf+ewxJj86
         wfS/Pmofd7Kjg+HrrnVqTAo0dFkBf4wo53x8WWEsvl/TiiLcQeYhZFKDhgs1hK309W9u
         2iWTr+bBRxYk7ovZaI7AkjvYaEzVx/8Vq5YguNrUAUylfGzHHskWmGKCD8UQUwiu+zyo
         NZG2nReHORM9+7b1tBzUG5JtkjlJ7jE09fX/7gD/7+JAfwm+rRUuHq+DUk+PECqvCKQJ
         qqTw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778810805; x=1779415605; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjuJ9mHs8BUnwhNge84Ub4CU+c74Kq0XaMXnsU0zEXw=;
        b=EqZFCWLLTQQ+Ta7j3G2dle6rWYffej4O6CccDQqaf4tPNId+HNTUgTxYixlHv1L74A
         RfS5F5TTkhbAnq6yol0FeuWemuZBhDkH7l5dus+CmmDfnVozjSvkQaZIgkJM2rCFexC7
         jL5sNrWTQe7AGJZOLV6YeJbvpxiXb2unfptI8l1dIt1nlOnD6B/tog6QuIvqDgJiW3p/
         KgHfMgj26X1MsP+G9+tBWWQgLVFs6hF2zq8mJB+fQfbVtVKmOK/d1/GGt5rtxDXNsS2t
         FSnAhN/70sAl+Cw7/ME9n3bpRm+kjXDrZvLDFaIHOpvtKU2UjhNzMdPt1HCk36qbmGnG
         OEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778810805; x=1779415605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HjuJ9mHs8BUnwhNge84Ub4CU+c74Kq0XaMXnsU0zEXw=;
        b=dimU0OR7jbws7bhy8okqbnwHmisZPUji1MfBy/CNZ530rHX9og7+zDQOlxGywnyvWq
         mNT+Vztj8QwbuR++1+DvoLEAozjBTcitb7UhYryOGbzdKCk7etyP+0uwUhJ0pLnFCBct
         JrzK3f/WveYvOkiAhMcs+vRpblbWmEpkCHOvwL9JLy7pAHUD6WHRA4anYP9LhLnT2ci8
         fbqsky03GXcV56pGgiefOFoh6xRsB3sLGRpGfIx60MwqA9JYHHQgNgMD4EdXhaFDvWHI
         FfyT5rs8kVEzHtms4fC4r7sJxH293rP0ZT1TwXXHCeuD6GR7Z+kaw7ONbj2NmG8l+tXE
         SPuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9AxCltYI9m/CZ2yu76BdBQMpDAUWNoe9iipyOffKfAb/aV3wSAbXVacfNqptvpDu3lxYUFCJQX60bw@lists.infradead.org
X-Gm-Message-State: AOJu0YzWkho7kMCGlKUP0Jr6ohxvEyzedTS+iYwdPArdf+zLegi35tH/
	3kvfWYO1KC4j7jgOzwA8PUT80c86QkuDgAVzn8YepGtyUbvm46K+/yO0ERpK/jjA1BqpQYqe6ed
	UTBNc2XR2tGvLBPLixzPtk1t1xyTFD2ze/mh5b8R28A==
X-Gm-Gg: Acq92OEUNcSutSPXMGBDtObbjJPKMfBTpOWTExAzxPCctxo+/RVL9x+mRA7yr8+ftvy
	J8NI/S8c+a1q/fWcArNj1ZJ060iLjPWM4AETP29oNaCMBU4AUqZGMYy2tuptZsqFjq0fdPPLbiA
	YP+YOzGgNW7puJ1imp25LkGMMxF7bHOc1MowW2d6X4V+d2s1gvqxmY+ICbDp7NfkfCFzsofbEts
	t3oR66G0Irh5TCSXtdtGcBOHRXE/TRROuGt+kWHgwsGcqqZE95/pvY075m7aRBzcPcHXqkPS2SU
	HQd+b7Gn0/csN0ffwtdK9CU54DL954pNGhAX3EDArLvadSE++BFWP87FEzPxOy1VtgELpA==
X-Received: by 2002:a05:6102:604a:b0:635:420c:9b00 with SMTP id
 ada2fe7eead31-63a3d427dc7mr1152896137.10.1778810805055; Thu, 14 May 2026
 19:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260328004518.1729186-1-mkhalfella@purestorage.com> <20260328004518.1729186-8-mkhalfella@purestorage.com>
In-Reply-To: <20260328004518.1729186-8-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 14 May 2026 19:06:33 -0700
X-Gm-Features: AVHnY4Li8OGSemmGzNiT7i9gDsNh9eZC0jG6ogjPtN5Rf6DKFnxoh2tPet7Hb3g
Message-ID: <CAPpK+O38qB5cib3_drVdUPcFf0MtF3XCjw7nvDAM6T4_qpp4xA@mail.gmail.com>
Subject: Re: [PATCH v4 07/15] nvme: Introduce FENCING and FENCED controller states
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>, 
	Hannes Reinecke <hare@suse.de>, Aaron Dailey <adailey@purestorage.com>, 
	Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_190646_504713_2DA67C76 
X-CRM114-Status: GOOD (  12.63  )
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

On Fri, Mar 27, 2026 at 5:46=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> FENCING is a new controller state that a LIVE controller enters when an
> error is encountered. While in FENCING state, inflight IOs that timeout
> are not canceled because they should be held until either CCR succeeds
> or time-based recovery completes. While the queues remain alive, requests
> are not allowed to be sent in this state, and the controller cannot be
> reset or deleted. This is intentional because resetting or deleting the
> controller results in canceling inflight IOs.
>
> FENCED is a short-term state the controller enters before it is reset.
> It exists only to prevent manual resets from happening while controller
> is in FENCING state.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

Reviewed-by: Randy Jennings <randyj@purestorage.com>

