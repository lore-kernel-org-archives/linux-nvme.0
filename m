From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 14 Aug 2019 12:26:22 -0700
Subject: [PATCH] nvme: Fix cntlid validation when not using NVMEoF
In-Reply-To: <20190814142610.2164-1-gpiccoli@canonical.com>
References: <20190814142610.2164-1-gpiccoli@canonical.com>
Message-ID: <58533d94-1390-f21c-236a-d8f226499582@grimberg.me>

This looks fine, wonder how this wasn't detected before
as this area was tested by Jon Derrick..

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
