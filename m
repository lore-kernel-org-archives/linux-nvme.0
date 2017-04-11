From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Tue, 11 Apr 2017 15:10:27 +0000
Subject: [PATCH v2] nvme-rdma: support devices with queue size < 32
In-Reply-To: <1807354347.364485979.1491900728245.JavaMail.zimbra@kalray.eu>
References: <1519881025.363156294.1491837154312.JavaMail.zimbra@kalray.eu>
 <1491838338.4199.5.camel@sandisk.com>
 <1807354347.364485979.1491900728245.JavaMail.zimbra@kalray.eu>
Message-ID: <1491923426.2654.1.camel@sandisk.com>

On Tue, 2017-04-11@10:52 +0200, Marta Rybczynska wrote:
> I think that we can remove the division (the modulo sig_limit). The sig_count
> is an u8 so it is really a type of variable you propose. It isn't used anywhere
> it seems so we can change the way it is used in the snippet to count until the
> signaling moment. It will give something like:
> 
> static inline nvme_rdma_queue_sig_limit(struct nvme_rdma_queue *queue)
> {
>        int sig_limit;
> 
>        /* We signal completion every queue depth/2 and also
>         * handle the case of possible device with queue_depth=1,
>         * where we would need to signal every message.
>         */
>        sig_limit = max(queue->queue_size / 2, 1);
>        queue->sig_count++;
>        if (queue->sig_count < sig_limit)
>            return 0;
>        queue->sig_count = 0;
>        return 1;
> }

Hello Marta,

Thank you for having addressed my feedback. Although this is not important, I
think it is possible to optimize the above code further as follows:
* Instead of initializing / resetting sig_count to zero, initialize it to sig_limit.
* Instead of incrementing sig_count in nvme_rdma_queue_sig_limit(), decrement it.
* Instead of comparing sig_count against sig_limit, compare it against zero.

Bart.
