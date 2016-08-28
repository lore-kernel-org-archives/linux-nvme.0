From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 28 Aug 2016 15:56:24 +0300
Subject: [PATCH WIP/RFC 6/6] nvme-rdma: keep a cm_id around during
 reconnect to get events
In-Reply-To: <b1ee02376df44ec240dc0bff956fe055687580f8.1472219586.git.swise@opengridcomputing.com>
References: <cover.1472219585.git.swise@opengridcomputing.com>
 <b1ee02376df44ec240dc0bff956fe055687580f8.1472219586.git.swise@opengridcomputing.com>
Message-ID: <8d13e79d-a111-8ec1-f8a6-42ece0ba46c9@grimberg.me>

I think this patch will have a problem running over a bond device which
can trigger a ADDR_CHANGE event. The problem with this is that with
bonding you can easily get a different device as a result. Also, I have
a feeling that we are not prepared to handle this scenario anyway (but
this approach are not making it any better...)

Care to respin your client registration patch so we can judge which
is better?
