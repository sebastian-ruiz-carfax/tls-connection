import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { promises as fs } from 'fs';

async function bootstrap() {
  const [ca, key, cert] = await Promise.all([
    fs.readFile('certs/ca.crt'), 
    fs.readFile('certs/server.key'),
    fs.readFile('certs/server.crt')
  ]);

  const app = await NestFactory.create(AppModule,{
    httpsOptions: {
      ca: ca.toString(),
      key: key.toString(),
      cert: cert.toString(),
      requestCert: true,
    }
  });
  await app.listen(3000);
}
bootstrap();
