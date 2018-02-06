From: davem@davemloft.net (David Miller)
Date: Tue, 06 Feb 2018 09:42:53 -0500 (EST)
Subject: [PATCH 1/3] net/utils: Introduce inet_addr_is_any
In-Reply-To: <20180206094432.12761-2-sagi@grimberg.me>
References: <20180206094432.12761-1-sagi@grimberg.me>
 <20180206094432.12761-2-sagi@grimberg.me>
Message-ID: <20180206.094253.2191113540764519816.davem@davemloft.net>

From: Sagi Grimberg <sagi@grimberg.me>
Date: Tue,  6 Feb 2018 11:44:30 +0200

> +		if (!memcmp(in6->sin6_addr.s6_addr,
> +			in6_any.sin6_addr.s6_addr, 16))

Please indent this properly.

When a function call spans multiple lines, the second and subsequent
lines of that call must be indented precisely to the column that follows
the openning parenthesis of that call.

You must use the appropriate number of TAB then SPACE characters
necessary to achieve this.

Thank you.
