From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 23 Jul 2019 13:29:54 -0700
Subject: [PATCH 4/5] nvme: wait until all completed request's complete fn
 is called
In-Reply-To: <20190722053954.25423-5-ming.lei@redhat.com>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-5-ming.lei@redhat.com>
Message-ID: <95f000ba-d3c8-f215-5e32-4b6e44954fb1@grimberg.me>

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

What about fc? I know that they are not canceling a request, but
they still complete it, shouldn't it also wait before removing?
