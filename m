From: sshah@solarflare.com (Shradha Shah)
Date: Wed, 29 Aug 2018 10:58:49 +0100
Subject: [PATCH 3/3] User mode server and client code
In-Reply-To: <697ba799-b8b4-c7b5-734d-09e898295a4f@solarflare.com>
References: <697ba799-b8b4-c7b5-734d-09e898295a4f@solarflare.com>
Message-ID: <2549131d-b213-dbbf-aa3e-4871b441e6cd@solarflare.com>

Signed-off-by: Shradha Shah <sshah at solarflare.com>
---
 tls/Makefile |  12 +++
 tls/client.c | 308 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tls/server.c | 183 +++++++++++++++++++++++++++++++++++
 3 files changed, 503 insertions(+)
 create mode 100644 tls/Makefile
 create mode 100644 tls/client.c
 create mode 100644 tls/server.c

diff --git a/tls/Makefile b/tls/Makefile
new file mode 100644
index 000000000000..3f387eae31b4
--- /dev/null
+++ b/tls/Makefile
@@ -0,0 +1,12 @@
+CC = gcc
+CFLAGS = -Wall -pedantic -O2 -std=gnu99
+LDFLAGS = -lgnutls -lpthread
+
+client: client.c
+	${CC} ${CLFLAGS} ${LDFLAGS} $^ -o $@
+
+server: server.c
+	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@
+
+clean:
+	rm -f *.o client server
diff --git a/tls/client.c b/tls/client.c
new file mode 100644
index 000000000000..fd3582be3ee9
--- /dev/null
+++ b/tls/client.c
@@ -0,0 +1,308 @@
+/*
+ * TLS support for NVMe over TCP.
+ * Copyright (c) 2017 Shradha Shah <sshah at solarflare.com>.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <stdarg.h>
+#include <string.h>
+#include <assert.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/socket.h>
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <gnutls/gnutls.h>
+#include <malloc.h>
+#include <alloca.h>
+#include <arpa/inet.h>
+#include <netinet/in.h>
+#include <netinet/ip.h>
+#include <netinet/tcp.h>
+#include <linux/netlink.h>
+#include <linux/tls.h>
+#include "../include/uapi/linux/nvme_netlink.h"
+
+#define PORT 5557
+#define EXIT_SUCCESS 0
+#define EXIT_FAILURE 1
+
+gnutls_psk_client_credentials_t pskcred;
+gnutls_session_t session[100];
+
+int ktls_socket_init(gnutls_session_t session)
+{
+	int err, ksd;
+	gnutls_datum_t mac_key;
+	gnutls_datum_t iv_read;
+	gnutls_datum_t iv_write;
+	gnutls_datum_t cipher_key_read;
+	gnutls_datum_t cipher_key_write;
+	unsigned char seq_number_read[8];
+	unsigned char seq_number_write[8];
+	struct tls12_crypto_info_aes_gcm_128 crypto_info;
+
+	/* now we need to initialize state after the handshake in the kernel*/
+	err = gnutls_record_get_state(session, 1, &mac_key, &iv_read,
+				      &cipher_key_read, seq_number_read);
+	if (err < 0) {
+		printf("failed to get receiving state from GnuTLS session/n");
+		goto end;
+	}
+
+	err = gnutls_record_get_state(session, 0, &mac_key, &iv_write,
+				      &cipher_key_write, seq_number_write);
+	if (err < 0) {
+		printf("failed to get sending state from Gnu TLS session/n");
+		goto end;
+	}
+
+	ksd = socket(AF_INET, SOCK_STREAM, 0);
+	if (ksd == -1) {
+		printf("socket error:/n");
+		return -1;
+	}
+
+	crypto_info.info.version = TLS_1_2_VERSION;
+	crypto_info.info.cipher_type = TLS_CIPHER_AES_GCM_128;
+	memcpy(crypto_info.iv, iv_write.data,  TLS_CIPHER_AES_GCM_128_IV_SIZE);
+	memcpy(crypto_info.rec_seq, seq_number_write,
+	       TLS_CIPHER_AES_GCM_128_REC_SEQ_SIZE);
+	memcpy(crypto_info.key, cipher_key_write.data,
+	       TLS_CIPHER_AES_GCM_128_KEY_SIZE);
+	memcpy(crypto_info.salt, iv_write.data,
+	       TLS_CIPHER_AES_GCM_128_SALT_SIZE);
+
+	err = setsockopt(ksd, SOL_TCP, TLS_TX, &crypto_info,
+			 sizeof(crypto_info));
+	if (err) {
+		printf("failed to set TLS sock opt %d\n", err);
+		goto end;
+	} else {
+		printf("created TLS socket fd=%d\n", ksd);
+	}
+	return ksd;
+ end:
+	return err;
+}
+
+void tls_close_session(gnutls_session_t session)
+{
+	gnutls_bye(session, GNUTLS_SHUT_RDWR);
+	gnutls_deinit(session);
+	gnutls_psk_free_client_credentials(pskcred);
+	gnutls_global_deinit();
+}
+
+int tls_handshake(int session_id, char *host)
+{
+	int ret, sd;
+	struct sockaddr_in sa;
+	char *desc;
+	const char *hint;
+	const gnutls_datum_t key = { (void *) "DEADBEEF", 8 };
+
+	/* for backwards compatibility with gnutls < 3.3.0 */
+	gnutls_global_init();
+	gnutls_psk_allocate_client_credentials(&pskcred);
+	gnutls_psk_set_client_credentials(pskcred, "test", &key,
+					  GNUTLS_PSK_KEY_HEX);
+
+	/* Initialize TLS session */
+	gnutls_init(&session[session_id], GNUTLS_CLIENT);
+	gnutls_priority_set_direct(session[session_id], "NORMAL:-KX-ALL:+PSK",
+				   NULL);
+	gnutls_credentials_set(session[session_id], GNUTLS_CRD_PSK, pskcred);
+
+	sd = socket(AF_INET, SOCK_STREAM, 0);
+	memset(&sa, '\0', sizeof(sa));
+	sa.sin_family = AF_INET;
+	sa.sin_port = htons(PORT);
+	inet_pton(AF_INET, host, &sa.sin_addr);
+
+	ret = connect(sd, (struct sockaddr *) &sa, sizeof(sa));
+	if (ret) {
+		fprintf(stderr, "Connect error%d\n", errno);
+		goto end;
+	}
+
+	gnutls_transport_set_int(session[session_id], sd);
+	gnutls_handshake_set_timeout(session[session_id],
+				     GNUTLS_DEFAULT_HANDSHAKE_TIMEOUT);
+
+	/* Perform the TLS handshake */
+	do {
+		ret = gnutls_handshake(session[session_id]);
+	} while (ret < 0 && gnutls_error_is_fatal(ret) == 0);
+	if (ret < 0) {
+		fprintf(stderr, "*** Handshake failed: %s\n",
+			gnutls_strerror(ret));
+		goto close;
+	}
+	printf("- Handshake was completed");
+	desc = gnutls_session_get_desc(session[session_id]);
+	printf("- Session info: %s\n", desc);
+
+	hint = gnutls_psk_client_get_hint(session[session_id]);
+	//replace the string "hint" with subsystem NQN
+	if (hint == NULL || strcmp(hint, "hint") != 0) {
+		printf("client: hint is not the expected: %s\n",
+		       gnutls_psk_client_get_hint(session[session_id]));
+		goto close;
+	}
+
+	gnutls_free(desc);
+
+	ret = ktls_socket_init(session[session_id]);
+	if (ret < 0) {
+		printf("failed to get KTLS socket");
+		goto close;
+	} else
+		goto success;
+close:
+	shutdown(sd, SHUT_RDWR); //no more receptions
+end:
+	tls_close_session(session[session_id]);
+success:
+	close(sd);
+	return ret;
+}
+
+static void daemonize(void)
+{
+	pid_t pid, sid;
+	int fd;
+
+	if (getppid() == 1)
+		return;
+	pid = fork();
+	if (pid < 0)
+		exit(EXIT_FAILURE);
+	if (pid > 0)
+		exit(EXIT_SUCCESS);
+
+	sid = setsid();
+	if (sid < 0)
+		exit(EXIT_FAILURE);
+
+	if ((chdir("/")) < 0)
+		exit(EXIT_FAILURE);
+
+	fd = open("/dev/null", O_RDWR, 0);
+	if (fd != -1) {
+		dup2(fd, STDIN_FILENO);
+		dup2(fd, STDOUT_FILENO);
+		dup2(fd, STDERR_FILENO);
+		if (fd > 2)
+			close(fd);
+	}
+	umask(027);
+}
+
+int main(int argc, char **argv)
+{
+	struct sockaddr_nl src_addr, dest_addr;
+	struct nlmsghdr *nlh_recv = NULL;
+	struct nlmsghdr *nlh_send = NULL;
+	struct msghdr msg;
+	struct iovec iov;
+	char buffer[4096];
+	int sock_fd, ktls_socket, i = 0, max_session_count = 0;
+	int group = TLS_HANDSHAKE_GRP;
+	struct nvme_tcp_uevent *tls_handshake_response_ptr;
+	int rc;
+
+	if (argc != 2) {
+		printf("TOO FEW ARGUMENTS\n");
+		exit(-1);
+	}
+
+	daemonize();
+
+	sock_fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_USERSOCK);
+
+	memset(&src_addr, 0, sizeof(src_addr));
+	src_addr.nl_family = AF_NETLINK;
+	src_addr.nl_pid = getpid();
+
+	bind(sock_fd, (struct sockaddr *)&src_addr,
+	     sizeof(src_addr));
+
+	if (setsockopt(sock_fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP,
+		       &group, sizeof(group)) < 0)
+		printf("setsockopt < 0\n");
+
+	memset(&dest_addr, 0, sizeof(dest_addr));
+	dest_addr.nl_family = AF_NETLINK;
+	dest_addr.nl_pid = 0;
+	dest_addr.nl_groups = 0;
+
+	while (1) {
+		iov.iov_base = (void *)buffer;
+		iov.iov_len = sizeof(buffer);
+		msg.msg_name = (void *)&dest_addr;
+		msg.msg_namelen = sizeof(dest_addr);
+		msg.msg_iov = &iov;
+		msg.msg_iovlen = 1;
+
+		printf("Waiting for message from kernel\n");
+
+		rc = recvmsg(sock_fd, &msg, 0);
+		if (rc > 0) {
+			nlh_recv = (struct nlmsghdr *)buffer;
+
+			tls_handshake_response_ptr = (struct nvme_tcp_uevent *)NLMSG_DATA(nlh_recv);
+
+			if (tls_handshake_response_ptr->ev_type == TLS_HANDSHAKE_INIT) {
+				ktls_socket = tls_handshake(i, argv[1]);
+				if (ktls_socket < 0) {
+					tls_handshake_response_ptr->ev_type = TLS_HANDSHAKE_ERROR;
+				} else {
+					i++;
+					max_session_count++;
+					tls_handshake_response_ptr->ev_type = TLS_HANDSHAKE_COMPLETE;
+					tls_handshake_response_ptr->tlsrep.sd = ktls_socket;
+					tls_handshake_response_ptr->tlsrep.pid = getpid();
+				}
+
+				nlh_send = (struct nlmsghdr *)malloc(NLMSG_SPACE(sizeof(struct nvme_tcp_uevent)));
+				memset(nlh_send, 0,
+				       NLMSG_SPACE(sizeof(struct nvme_tcp_uevent)));
+				nlh_send->nlmsg_len = NLMSG_SPACE(sizeof(struct nvme_tcp_uevent));
+				nlh_send->nlmsg_pid = getpid();
+				nlh_send->nlmsg_flags = 0;
+
+				memcpy((NLMSG_DATA(nlh_send)), (const unsigned char *)(NLMSG_DATA(nlh_recv)), sizeof(struct nvme_tcp_uevent));
+
+				iov.iov_base = (void *)nlh_send;
+				iov.iov_len = nlh_send->nlmsg_len;
+				msg.msg_name = (void *)&dest_addr;
+				msg.msg_namelen = sizeof(dest_addr);
+				msg.msg_iov = &iov;
+				msg.msg_iovlen = 1;
+
+				printf("Sending message to kernel\n");
+				sendmsg(sock_fd, &msg, 0);
+				free(nlh_send);
+			}
+			memset(&msg, 0, sizeof(msg));
+			memset(&iov, 0, sizeof(iov));
+			memset(buffer, 0, 4096);
+		}
+	}
+	close(sock_fd);
+	for (i = 0; i < max_session_count; i++)
+		tls_close_session(session[i]);
+	return ktls_socket;
+}
+
diff --git a/tls/server.c b/tls/server.c
new file mode 100644
index 000000000000..86f3c959077b
--- /dev/null
+++ b/tls/server.c
@@ -0,0 +1,183 @@
+/*
+ * TLS support for NVMe over TCP.
+ * Copyright (c) 2017 Shradha Shah <sshah at solarflare.com>.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <assert.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <malloc.h>
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/socket.h>
+#include <arpa/inet.h>
+#include <netinet/in.h>
+#include <sys/select.h>
+#include <netdb.h>
+
+#include <gnutls/gnutls.h>
+#include <gnutls/compat.h>
+#include <gnutls/crypto.h>
+
+#define PORT 5557 /* listen to 5556 port */
+#define KEYFILE "key.pem"
+#define CERTFILE "cert.pem"
+#define CAFILE "/etc/pki/ca-trust/extracted/openssl/ca-bundle.trust.crt"
+#define CRLFILE "/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem"
+#define EXIT_SUCCESS 0
+#define EXIT_FAILURE 1
+
+static gnutls_dh_params_t dh_params;
+
+static int pskfunc(gnutls_session_t session, const char *username,
+		   gnutls_datum_t *key)
+{
+	printf("psk: username %s\n", username);
+	key->data = gnutls_malloc(4);
+	key->data[0] = 0xDE;
+	key->data[1] = 0xAD;
+	key->data[2] = 0xBE;
+	key->data[3] = 0xEF;
+	key->size = 4;
+	return 0;
+}
+
+static int generate_dh_params(void)
+{
+	int bits = gnutls_sec_param_to_pk_bits(GNUTLS_PK_DH,
+					       GNUTLS_SEC_PARAM_LEGACY);
+
+	/* Generate Diffie-Hellman parameters - for use with DHE
+	 * kx algorithms. When short bit length is used, it might
+	 * be wise to regenerate parameters often.
+	 */
+	gnutls_dh_params_init(&dh_params);
+	gnutls_dh_params_generate2(dh_params, bits);
+	return EXIT_SUCCESS;
+}
+
+static void daemonize(void)
+{
+	pid_t pid, sid;
+	int fd;
+
+	if (getppid() == 1)
+		return;
+
+	pid = fork();
+	if (pid < 0)
+		exit(EXIT_FAILURE);
+	if (pid > 0)
+		exit(EXIT_SUCCESS);
+
+	sid = setsid();
+	if (sid < 0)
+		exit(EXIT_FAILURE);
+
+	if ((chdir("/")) < 0)
+		exit(EXIT_FAILURE);
+
+	fd = open("/dev/null", O_RDWR, 0);
+	if (fd != -1) {
+		dup2(fd, STDIN_FILENO);
+		dup2(fd, STDOUT_FILENO);
+		dup2(fd, STDERR_FILENO);
+		if (fd > 2)
+			close(fd);
+	}
+	umask(027);
+}
+
+int main(void)
+{
+	int listen_sd;
+	int sd, ret;
+	gnutls_psk_server_credentials_t server_pskcred;
+	struct sockaddr_in sa_serv;
+	struct sockaddr_in sa_cli;
+	socklen_t client_len;
+	char topbuf[512];
+	gnutls_session_t session;
+	int optval = 1;
+	char *desc;
+
+	daemonize();
+	/* for backwards compatibility with gnutls < 3.3.0 */
+	gnutls_global_init();
+	gnutls_psk_allocate_server_credentials(&server_pskcred);
+	gnutls_psk_set_server_credentials_hint(server_pskcred, "hint");
+	gnutls_psk_set_server_credentials_function(server_pskcred, pskfunc);
+	generate_dh_params();
+	gnutls_psk_set_server_dh_params(server_pskcred, dh_params);
+
+	/* Socket operations */
+	listen_sd = socket(AF_INET, SOCK_STREAM, 0);
+
+	memset(&sa_serv, '\0', sizeof(sa_serv));
+	sa_serv.sin_family = AF_INET;
+	sa_serv.sin_addr.s_addr = INADDR_ANY;
+	sa_serv.sin_port = htons(PORT); /* Server Port number */
+
+	setsockopt(listen_sd, SOL_SOCKET, SO_REUSEADDR,
+		   (void *) &optval, sizeof(int));
+	bind(listen_sd, (struct sockaddr *) &sa_serv, sizeof(sa_serv));
+	listen(listen_sd, 1024);
+	printf("Server ready. Listening to port '%d'.", PORT);
+
+	client_len = sizeof(sa_cli);
+	for (;;) {
+		gnutls_init(&session, GNUTLS_SERVER);
+		gnutls_priority_set_direct(session, "NORMAL:-KX-ALL:+PSK",
+					   NULL);
+		gnutls_credentials_set(session, GNUTLS_CRD_PSK,
+				       server_pskcred);
+
+		sd = accept(listen_sd, (struct sockaddr *) &sa_cli,
+			    &client_len);
+		printf("- connection from %s, port %d",
+		       inet_ntop(AF_INET, &sa_cli.sin_addr, topbuf,
+				 sizeof(topbuf)), ntohs(sa_cli.sin_port));
+		gnutls_transport_set_int(session, sd);
+		do {
+			ret = gnutls_handshake(session);
+		} while (ret < 0 && gnutls_error_is_fatal(ret) == 0);
+		if (ret < 0) {
+			close(sd);
+			gnutls_deinit(session);
+			fprintf(stderr, "*** Handshake has failed (%s)",
+				gnutls_strerror(ret));
+			continue;
+		}
+		printf("- Handshake was completed");
+		desc = gnutls_session_get_desc(session);
+		printf("- Session info: %s\n", desc);
+		gnutls_free(desc);
+
+		//KTLS socket
+		//pass the KTLS socket to kernel
+
+		close(sd);
+	}
+	close(listen_sd);
+	/* do not wait for the peer to close the connection. */
+	gnutls_bye(session, GNUTLS_SHUT_WR);
+	gnutls_deinit(session);
+	gnutls_dh_params_deinit(dh_params);
+	gnutls_psk_free_server_credentials(server_pskcred);
+	gnutls_global_deinit();
+
+	return EXIT_SUCCESS;
+}
+
-- 
2.14.4
