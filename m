From: bsingharora@gmail.com (Balbir Singh)
Date: Fri, 19 Jul 2019 15:45:20 +1000
Subject: [PATCH v3] nvme-pci: Support shared tags across queues for Apple
 2018 controllers
In-Reply-To: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
References: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
Message-ID: <CAKTCnzm25sa_6p=U-FAL9dEPdd13OJ446hqhZfHPn5zrYmAKRg@mail.gmail.com>

On Fri, Jul 19, 2019 at 3:31 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> From 8dcba2ef5b1466b023b88b4eca463b30de78d9eb Mon Sep 17 00:00:00 2001
> From: Benjamin Herrenschmidt <benh at kernel.crashing.org>
> Date: Fri, 19 Jul 2019 15:03:06 +1000
> Subject:
>
> Another issue with the Apple T2 based 2018 controllers seem to be
> that they blow up (and shut the machine down) if there's a tag
> collision between the IO queue and the Admin queue.
>
> My suspicion is that they use our tags for their internal tracking
> and don't mix them with the queue id. They also seem to not like
> when tags go beyond the IO queue depth, ie 128 tags.
>
> This adds a quirk that marks tags 0..31 of the IO queue reserved
>
> Signed-off-by: Benjamin Herrenschmidt <benh at kernel.crashing.org>
> ---

Reviewed-by: Balbir Singh <bsingharora at gmail.com>
